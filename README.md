Programming Elixir :funtional, concurrent, pragmatic, fun 2014
-----

Why **Elixir** is Awesome!
* Programmer focussed
* OTP Power + Ruby love
* Funtional but pramatic
* Standard Toolset

> OTP is an application operating system and a set of libraries and procedures used for building large-scale, fault-tolerant, distributed applicatoins.

> OTP is a domain-independent set of frameworks, principles, and patterns that guide and support the structure, design, implementation, and deployment of Erlang systems.

Erlang/OTP
1. Erlang/Beam
1. Tools
1. Libraries
1. Patterns

alias, require, import and use
----
1. alias
  *alias* allows you to set up aliases for any given module name.
	Imagine a module uses a specialized list implemented in `Math.List`.
	The `alias` directive allows referring to `Math.List` just as List within the module definition:
```
defmodule Stats do 
  alias Math.List, as: List
  # In the remaining module definition List expands to Math.List.
end
```	 
`alias Math.List` is the same as `alias Math.List, as: List`


1. require
   Elixir provides macros as a mechanism for meta-programming(writing code that generates code).
		Macros are expanded at compile time

   Public functions in modules are globally available, but in order to use macros, you need to option by requiring the module they are defined in.
```
iex(1)> Integer.is_odd(3)
** (UndefinedFunctionError) function Integer.is_odd/1 is undefined or private. However there is a macro with the same name and arity. Be sure to require Integer if you intend to invoke this macro
    (elixir) Integer.is_odd(3)
iex(1)> require Integer
Integer
iex(2)> Integer.is_odd(3)
true
```
In Elixir, Integer.is_odd/1 is defined as a macro so that it can be used as a guard. This means that, in order to invoke Integer.is_odd/1, We need to first the `Integer` module.


1. import
    We use *import* whenever we want to easily access functions or macros from other module without using the fully-qulified name. 
		For instance,if we want to use the duplicate/2 function from the List module serveral times, we can import it:
```
iex> import List, only: [duplicate: 2]
List
iex> duplicate :ok, 3
[:ok, :ok, :ok]
```
In this case, we are importing only the function `duplicate` (with arity 2) from `List`.
Although `:only` is optional, its usage is recommended in order to avoid importing all the functions of a given module inside the namespace. `:except` could also be given as an option in order to import everything in a module *except* a list of functions.

`import` also supports `:macros` and `:functions` to be given to `:only`. For example, to import all macros, one could write:

`import Integer, only: :macros`

or to import all functions, you could write:

`import Integer, only: :functions`

1. use
   The `use` macro is frequently used by developers to bring external functionality into the current lexical scope, often modules.
   For example, in order to write tests using the ExUnit framework, a develper should use the `ExUnit.Case` module:
```
defmodule AssertionTest do 
  use ExUnit.Case, async: true

	test "always pass" do 
	  assert true
	end
end
```
Behind the scenes, `use` requires the given module and then calls the `__using__/1` callback on it allowing the module to inject some code into the current context.
Generally speacking, the following module:
```
defmodule Example do 
  use Feature, option: :value
end
# is compiled into:
defmodule Example do 
  require Feature
	Feature.__using__(option: :value)
end
```

