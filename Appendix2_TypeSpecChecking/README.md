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

