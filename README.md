# Programming Elixir :funtional, concurrent, pragmatic, fun 2014

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
	imagine a module uses a specialized list implemented in *Math.List*.
	The alias directive allows referring to Math.List just as List within the module definition:
```
defmodule Stats do 
  alias Math.List, as: List
  # In the remaining module definition List expands to Math.List.
end
```	 

1. require
    Elixir provides macros as a mechanism for meta-programming(writing code that generates code).
		Macros are expanded at compile time

1. import
    We use *import* whenever we want to easily access functions or macros from other module without using the fully-qulified name. 
		For instance,if we want to use the duplicate/2 function from the List module serveral times, we can import it:
```
iex> import List, only: [duplicate: 2]
List
iex> duplicate :ok, 3
[:ok, :ok, :ok]
```

1. use

