## Linking Modules:Behavior(u)rs and Use
 We'll explore what lines such as _use GenServer_ actually do, and how we can write modules that extend the capabilities of other modules that use them.

### Behaviors
an Elixir behaviour is nothing more than a list of functions. A module that declares that it implements a particular behaviour must implement all of the associated functions. If it doesn't, Elixir will generate a compilation warning.

A behavior is therefore a little like an _interface_ in Java. A module uses it to decalre that it implements a particular interface.
For example, an OTP GenServer should implement a standard set of callbacks(*handle_all,handle_cast,* and so on). By declaring that our module implements that behaviour, we let the compiler validate that we have actually supplied the necessary interface. This reduces the chance of an unexpected runtime error.

### Defining Behaviours
We define a behaviour using the Elixir *Behaviour* module, combined with *defcallback* definitions.

For example, Elixir comes with a URI parsing library. This library delegates a couple of functions to protocol-specific libraries (so there's a library for HTTP,one for FTP, and so on). These protocol-specific libraries must define two functions: **parse** and **default_port**.

### Declaring Behaviours
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

### Putting It Together --- Tracing Method Calls
 
