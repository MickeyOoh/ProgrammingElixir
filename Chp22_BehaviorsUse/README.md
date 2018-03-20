Linking Modules:Behavior(u)rs and Use
----
 We'll explore what lines such as _use GenServer_ actually do, and how we can write modules that extend the capabilities of other modules that use them.

Behaviors
----
an Elixir behaviour is nothing more than a list of functions. A module that declares that it implements a particular behaviour must implement all of the associated functions. If it doesn't, Elixir will generate a compilation warning.

A behavior is therefore a little like an _interface_ in Java. A module uses it to decalre that it implements a particular interface.
For example, an OTP GenServer should implement a standard set of callbacks(*handle_all,handle_cast,* and so on). By declaring that our module implements that behaviour, we let the compiler validate that we have actually supplied the necessary interface. This reduces the chance of an unexpected runtime error.

### Defining Behaviours
We define a behaviour with *defcallback* definitions.

For example, the *mix* utility handles various source code control methods(Source Code Manager(SCM)).
	Out of the box, it supports git and the local filesystem. However, interface to the SCM is defined using a behaviour, allowing new version control systems to be added cleanly.

The behaviour is defined in the module Mix.Scm:
```
defmodule Mix.SCM do 
  @moduledoc """
  This module provides helper functions and defines the behaviour
  required by any SCM used by Mix.
  """
  @type opts :: Keyword.t
  @doc """
  Returns a boolean if the dependency can be fetched or it is meant
  to be previously available in the filesystem.
  local dependencies (i.e. non fetchable ones) are automatically
  recompiled every time the parent project is compiled.
  """
  @callback fetchable? :: boolean
  @doc """
  Returns a string representing the SCM. This is used when printing
  the dependency and not for inspection, so the amount of information
  should be concise and easy to spot.
  """
  @callback format(opts) :: String.t
  # and so on for 8 more callbacks
```

  Having defined the behaviour, we can declare that some other module implements it using the @behaviour attribute.
```
defmodule URI.HTTP do 
  @behaviour URI.Parser
	def default_port(), do: 80
	def parse(info), do: info
end
```
This module will compile cleanly. However, imagine we'd misspelled *default_port:*
```
defmodule URI.HTTP do 
  @behaviour URI.Parser
	
	def default_prot(), do: 80
	def parse(info), do: info
end
```
> According to book "default_prot() has error as a misspelled", but "behaviour URI.Parser is undefined" it says and error doesn't happen.

### Use and __using__

Putting It Together --- Tracing Method Calls
---- 

Let's work through a larger example.
We want to write a module called *Tracer*.
If we use Tracer in another module, entry and exit tracing will be added to any subsequently defined function. 

![tracer.ex](./tracer.ex)

```
==> call    puts_sum_three(1, 2, 3)
6
<== returns 6
==> call    add_list([5,6,7,8])
<== returns 26
```

My approach to writing this kind of code is to start by exploring what we have to work with,
and then to generlize. The goal is to metaprogram as little as possible.
It looks as if we have to override the *def* macro, which is defined in *Kernel*. 
So let's do that and see what gets passed to *def* when we define a method.

![tracer1.ex](tracer1.ex)

This outputs
```
{:puts_sum_three, [line: 13],
 [{:a, [line: 13], nil}, {:b, [line: 13], nil}, {:c, [line: 13], nil}]}
 {:add_list, [line: 14], [{:list, [line: 14], nil}]}
 ** (UndefinedFunctionError) function Test.puts_sum_three/3 is undefined or private
```

The definition part of each method is a three-element tuple. 
The first element is the name
the second is the line on which it is defined
and the third is a list of the parameters, where each parameter is itself a tuple.

We also get an error: *puts_sum_three* is undefined. That's not surprising– we interceptd the *def* that defined it, and we didn't create the function.

You may be wondering about the form of the macro definition: *defmacro def(definition, do: _content)...*. The *do:* in the parameters is not special systax: It's a pattern match on the block passed as the function body, which is a keyword list.
You may also be wondering if we have affected the built-in *Kernel.def* macro. The answer is no. We've created another macro, also called *def*, which is defined in the scope of the *Tracer* module. In our *Test* module we tell Elixir not to import the Kernel version of *def* but instead to import the version from *Tracer*. Shortly, we'll make use of the fact that the original *Kernel* implementation is unaffected.

![tracer2.ex](tracer2.ex)


![tracer3.ex](tracer3.ex)

Let's package our *Tracer* module so clients only have to add *use Tracer* to their own modules. We'll implement the __using__ callback. The tricky part here is differentiating between the two modules:
Tracer and the module that uses it.

![tracer4.ex](tracer4.ex)


Use use
-----

