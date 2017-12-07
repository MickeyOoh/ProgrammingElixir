Type Specifications and Type Checking
-----
We saw that we defined callbacks in terms of their parameter types and return value.
For example, we might write
```
@callback parse(uri_info :: URI.Info.t) :: URI.Info.t
@callback default_port() :: integer
```

The terms *URI.Info.t* and *integer* are examples of type specifiations.
No special parsing is involved. This is a great illustration of the power of Elixir metaprogramming.

When Specifiations Are Used
-----
Elixir type specifications come from Erlang. It is very common to see Erlang code where every exported(public) function is preceded by a **-spec** line.
This is metadata that gives type information. The following code comes from the Elixir parser (which is [currently] written in Erlang).
It says the *return_error* function takes two parameters, an integer and any type, and never returns.

```
-spec return_error(integer(), any()) -> no_return().
return_error(Line, Message) ->
    throw({error, {Line, ?MODULE, Message}}).
```

One of the reasons the Erlang folks do this is to document their code.
You can read it inline while reading the source, and you can also read it in the pages created by their documentation tool.
The other reason is that they have tools such as *dialyzer* that perform static analysis of Erlang code and report on some kinds of type mismatches.

These same benefits can apply to Elixir code. We have the **@spec** module attribute for documenting a function's type specification; in *iex* we have the **s** helper for displaying specifications and the **t** helper for showing user-defined types.
You can also run Erlang tools such as dialyzer on compiled Elixir *.beam* files.

Specifying a Type
-----
A type is simply a subset of all possible values in a language. 
the basic types in Elixir are **any, atom, char_list, float, fun, integer, map, none, pid, port, reference, and tuple**.

#### Collection Types

<< >>
   An empty binary (size 0)
<< _ :: size >>
   A sequence of *size* bits. This is called a *bitstring*.
<< _ :: size * unit_size >>
   A sequence of *size* units, where each unit is *unit_size* bits long.

#### Types and Structures

```
defmodule LineItem do 
  defstruct sku: "", quantity: 1
	@type t :: %LineItem{sku: String.t, quantity: integer}
end
```

#### Anonymous Functions
Anonymous functions are specified using(head -> return_type)

The head specifies the arity and possibly the types of the function parameters.
It can be ..., meaning an arbitrary number of  arbitrarily typed arguments, or a list of types, in which case the number of types is the function's arity.

(... -> integer)							# Arbitrary parameters; returns an integer 
(list(integer) -> integer)    # Takes a list of integers and returns an integer
(() -> String.t)							# 
(integer, atom -> list(atom)) #

You can put parentheses around the head if you find it clearer.

( atom, float -> list)
( (atom, float) -> list)
(list(integer) -> integer)
((list(integer)) -> integer)

#### Handling Truthly Values
The types *as_boolean(T)* says that the actual value matched will be of type T,
but the function that uses the value will treat it as a *truthy* value(anything other than *nil* or *false* is considered true). 

`@spec count(t, (element -> as_boolean(term))) :: non_reg_integer`

#### Some Example




Defining New Types
-----
The attribute **@type** can be used to define new types.

@type type_name :: type_specification

Elixir uses this to predefine some built-in types and aliases.

@type term :: any
@type binary :: <<_::_*8>>

Types and specs  by elixir-lang.org
-----
Elixir is a dynamically typed language, so all types in Elixir are inferred by the runtime.
Nonetheless, Elixir comes with *typespecs*, which are a notation used for:
1. declaring typed function signatures
1. declaring custom data types.

Function specifications
-----
By default, Elixir provides some basic types, such as *integer* or *pid*, as well as more complex types: for example, the *round/1* function, which rounds a float to its nearest integer, takes a *number* as an argument(an *integer* or a *float*) and returns an *integer*.
As you can see in its documentation. *round/1*'s typed signature is written as:

`round(number) :: integer`

**::** means that the function on the left side returns a value whose type is what's on the right side.
Function specs are written with the **@spec** directive, placed right before the function definition. the *round/1* function could be written as:

`@spec round(number) :: integer`
`def round(number9, do: # implementation...`


Defining custom types
-----
While Elixir provides a lot of useful built-in types, it's convenient to define custom types when appropriate. This can be done when defining modules through the *@type* directive.

Say we have a `LousyCalculator` module, which performs the usual arithmetic operations(sum, product, and so on) but, instead of returning numbers, it returns tuples with the result of an operation as the first element and a random remark as the second element.

```
defmodule LousyCalculator do 
  @spec add(number, number) :: {number, String.t}
	def add(x, y), do: {x + y, "You need a calculator to do that?!"}

	@spec multiply(number, number) :: {number, String.t}
	def multiply(x, y), do: {x * y, "Jeez, come out!"}
end
```

As you can see in the example, *tuples* are a compound type and tuple is idnentified by the types inside it. To understand why String.t is not written as *string*, have another look at the ![notes in the typespecs docs.](https://hexdocs.pm/elixir/typespecs.html#noteds)
Note:
  Elixir discourages the use of type `t:string/0` as it might be confused with binaries which are referred to as "strings" in Elixir(as opposed to character lists). In order to use the type that is called `t:string/0` in Erlang, one has to use the `t:charlist/0` type which is a synonym for `string`. If you use `string`, you'll get a warning from the compiler.
	If you want to refer to the "string" type(the one opreated on by functions in the `String` module), use `string.t/0` type instead.
	 
Defining function specs this way works, but it quickly becomes annoying since we're repeating the type {number, String.t} over and over. We can use the @type directive in order to declare our own custom type.

```
defmodule LousyCalculator do 
  @typedoc """
	Just a number followed by a string.
	"""
	@type number_with_remark :: {number, String.t}

	@spec add(number, number) :: number_with_remark
	def add(x, y), do: { x * y, "You need a calculator to do that?"}

	@spec multiply(number, number) :: number_with_remark
	def multiply(x, y), do: {x * y, "It is like addition on steroids."}
end
```

Behaviours
----
Many modules share the same pulic API. Take a look at Plug, which, as its description staes, is a *specification* for composable modules in web applications. Each plug is a module which has to implement at least two public functions: `init/1` and `call/2`.

Behaviours provide a way to:
* define a set of functions tht have to be implemented by a module;
* ensure that a module implements all the functions in that set.

 

