## An Aside - What are Types?
#### We can use the [...] literal to create a list, and the | operator to deconstruct and build lists.
#### Then there's another layer. _List_ module provides a set of functions that operate on lists. These functions simply use recursion and the | operator to add this extra functionality.
#### The *Keyword* type is an Elixir module. But it is impplemented as a list of tuples:
```
options = [ {:width, 72}, {:style, "light"}, {:style, "print"}]
```
Clearly this is still a list, and all the list functions will work on it. But Elixir adds functionality to give you dictionary-like behaviour.
```
iex> options = [ {:width, 72}, {:style, "light"}, {:style, "print"}]
[width: 72, style: "light", style: "print"]
iex> List.last options
{:style, "print"}
iex> Keyword.get_values options, :style
["light", "print"]

```
In a way, this is a form of the duck typing that is talked about in dynamic object-oriented languages. The *Keyword* module doesn't have an underlying primitive data type, It simply assumes that any value it works on is a list that has been structured a certain way.

