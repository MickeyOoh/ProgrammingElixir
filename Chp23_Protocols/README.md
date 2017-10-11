Protocols -- Polymorphic Functions
=======
We have used the *inspect* function many times in this book. It returns a printable representation of any value as a binary(which is what we hard-core folks call strings).

But stop and thinkfor a minute. Just how can Elixir, which doesn't have objects, know what to call to do the conversion to a binary?
Youu can pass *inspect* anything, and Elixir somehow makes sense of it.

A protocol is a little like the behaviours we saw in the previous chapter in that it defines the functions that must be provided to achieve something.
But a behaviour is internal to a module -- the module implements the behaviour. Protocols are different -- you can place a protocol's implementation completely outside the module.
This means you can extend modules' functionality without having to add code to them -- in fact, you can extend the functionality even if you don't have the modules' source code.

Defining a Protocol
-----
Protocol definitions are very similar to basic module definitions. They can contain module- and function-level documentation (@moduledoc and @doc), and they will contain one or more function definitions. However, these functions will not have bodies -- they are there simply to decalre the interface that the protocol requires.

```samplecode:
defprotocol Inspect do 
  def inspect(thing, opts)
end
```
Just like a module, the protocol defines one or more functions. But we implement the code separately.

Implementing a Protocol
----
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
|:--------|:--------|:--------|:--------|:--------|:--------|
| Any      | Atom     | BitString|Float     | Function | Integer  |
| List     | PID      | Port     |Record    | Reference| Tuple    |

You can list multiple types on a single _defimpl_. For example, the following protocol can be called to determine if a type is a collection:

`$ elixir is_collection.exs`

We write _defimpl_ stanzas for the three collection types: _List_, _Tuple_, and _BitString_. If we use _Any_, though, we also have to add an annotation to the protocol definition. Thats what the **@fallback_to_any** line does.

Protocols and Structs
-----
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

### Built-in Protocols
Elixir comes with the following protocols:
* Enumerable and Collectable
* Inspect
* List.Chars
* String.Chars

To play with these, we'll implement a trivial datatype that represents the collection of 0s and 1s an integer. The underlying representation is trival:

![bitmap.exs](bitmap.exs)

The fetch_bit function uses the >>> and &&& functions in the built-in Bitwise
library to extract a particular bit.

Bitwise library:
  A set of macros that perform calculations on bits.
  the macros in this module come in two flavors: named or operators.
-  function -
	- left &&& right
	-	left <<< right - left data by left bitshift
	-	left >>> right - left data by right bitshift
	-	left ^^^ right - xor
	-	band(left, right) - AND of its arguments
	-	bnot(expr)        - Not of its arguments
	-	bor(left,right)   - OR
	-	bsl(left,right)   - left bitshift
	-	bsr(left,right)   - right bitshift
	-	left ||| right    - OR
	-	~~~expr           - NOT of its argument


#### Built-in Protocols: Enumerable and Collectable
The Enumerable protocol is the basis of all the functions in the Enum module– 

The protocol is defined in terms of three functions:
```
defprotocol Enumerable do 
  def count(collection)
	def member?(collection, value)
	def reduce(collection, acc, fun)
end
```

*count* returns the number of elements in the collection, *member?* is truthy if the collection contains *vlaue*.
*reduce* applies the given function to successive values in the collection and the accumulator;the value it reduces becomes the next accumulator. Perhaps surprisingly, all the **Enum** functions can be defined in terms of these three.
However, life isn't that simple.. Maybe you're using *Enum.find* to find a value in a large collection.
 
			 
Let's define a type _Bitmap_ that lets us access the individual bits in a number's binary representation. To do this, we'll create a struct that contains a single field, *value*.

```
defimpl Enumerable, for: Bitmap do 
  import :math, only: [log: 1]
	def count(%Bitmap{value: value}) do 
	  { :ok, trunc(log(abs(value))/log(2)) + 1}
	end
end

fifty = %Bitmap{value: 50}
IO.puts Enum.cont fifty   #=> 6
```

Our *count* method returns a tuple containing *:ok* and the actual count.
If our collection was not countable(perhaps it represents data coming over a network connection), we would return {:error, __MODULE__}.

```
def member?(value, bit_number) do 
  { :ok, 0 <= bit_number && bit_number < Enum.count(value) }
end

IO.puts Enum.member? fifty, 4   #=> true
IO.puts Enum.member? fifty, 6   #=> false
```
The meaning of the :ok part is slightly different. You'll normally return 
{:ok, boolean} for all collections where you know the size, and {:error, __MODULE__} otherwise.
In this way, it is like *count*. However, the reason you do it is different.
If you return :ok it means you have a fast way of determining membership.
If you return :error, you're saying you don't. In this case, the enumerable code will simply perform a linear search.

`reduce(enumerable, accumulator, function)`

*reduce* takes each item in turn from *enumerable*, passing it and the current value of the accumulator to the function.
The value the function returns becomes the accumulator's next value.

The reduce function we implement for the Enumerable protocol is the same.
But it has some additional conventions associated with it. These conventions are used to manage the early halting and suspension when iterating over streams.

The first convention is that the accumulator value is passed as th second element of a tuple. The first element is a verb telling our reduce function what to do:

:cont   - Countinue
:halt   - Terminate
:suspend- Temporarily suspend
The second convention

:done     - this is the final value - we've reached the end of the enumerable
:halted   - We terminated the enumeration because we were passed :halt.
:suspended- Response to a suspend.

![bitmap_enumerable.exs](bitmap_enumerable.exs)

 
