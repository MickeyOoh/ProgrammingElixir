## Protocols -- Polymorphic Functions
A protocol is a littel like the behaviours that it defines the functions that must be provided to achieve something. But a behaviour is internal to a module -- the protocol's implementation completely outside the module.
This means you can extend modules' functionality even if you don't have the modules' source code.
### Defining a Protocol
Protocol definitions are very similar to basic module definitions. They can contain module- and function-level documentation (@moduledoc and @doc), and they will contain one or more function definitions. However, these functions will not have bodies -- they are there simply to decalre the interface that the protocol requires.

```samplecode:
defprotocol Inspect do 
  def inspect(thing, opts)
end
```
### Implementing a Protocol
The *defimpl* macro lets you give Elixir the imlementation of a protocol for one or more types. The code that follows is the implementation of the _inspect_ protocol for PIDs and references.

> ### iolist_to_binary function is undefined --> Error **It doen't Work!!**

```
iex> inspect self

iex> defimpl Inspect, for: PID do 
...>   def inspect(pid, _) do 
...>     "#Process: " <> iolist_to_binary(:erlang.pid_to_list(pid)) <> "!!"
...>   end
...> end


iex> inspect self
"#Process: <x.xx.x>!!"
```
### the Available Types
You can define implementations for one or more of the following types:

|          |          |          |          |          |          |
|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|
| Any      | Atom     | BitString|Float     | Function | Integer  |
| List     | PID      | Port     |Record    | Reference| Tuple    |

You can list multiple types on a single _defimpl_. For example, the following protocol can be called to determine if a type is a collection:
```
$ elixir is_collection.exs
```

We write _defimpl_ stanzas for the three collection types: _List_, _Tuple_, and _BitString_. If we use _Any_, though, we also have to add an annotation to the protocol definition. Thats what the **@fallback_to_any** line does.

### Protocols and Structs
Elixir doesn't have classes. but it does have user-defined types.**Surprise!!** It pulls off this magic using structs and a few conventions.

```
# basic.exs
defmodule Blob do 
  defstruct content: nil
end
........
iex> c("basic.exs")
[Blob]
iex> b = %Blob{content: 123}
%Blob{content: 123}
iex> inspect b
"%Blob{content: 123}"
```
It looks for all the world as if we've created some new type, the blob. But that's only because Elixir is hiding something from us. By default, _inspet_ recoginzes structs. If we turn this off using the _structs: false_ option, inspect reveals the true nature of our blob value:
```
iex> inspect b, structs: false
"%{__struct__: Blob, content: 123}"
```

### Built-in Protocols: Access
Let's define a type _Bitmap_ that lets us access the individual bits in a number's binary representation. To do this, we'll create a struct that contains a single field, *value*.

 
