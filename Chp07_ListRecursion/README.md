Lists and Recursion
----

Heads and Tails
----


How iex Displays Lists
----

> _Strings and Binaries_
> Elixir has two representations for strings.
> One is the familiar sequnce of characters in consecutive memory locations. Literals written with double quotes use this form.
> The second form, using single quotes, represents strings as a list of integer codepoints. So the string 'cat' is the three codepoints: 99, 97, and 116

> this is a headache for **iex**. When it sees a list like [99, 97, 116] it doesn't know if it is supposed to be the string 'cat' or a list of three numbers.
 
code:
```
iex> [99, 97, 116]
'cat'
iex> [99, 97, 116, 0]
[99, 97, 116, 0]
```

## Using Head and Tail to build a list
square code:
```
defmodule MyList do 
  def len([]),			       do: 0
	def len([ head | tail]), do: 1 + len(tail)
  def add_1([]),              do: []
	def add_1([ head | tail ]), do: [ head + 1 | add_1(tail) ]
end
```

## Creaing a Map Function
map code:
```
defmodule MyList do 
  def map([], _func),				do: []
	def map([head|tail], func), do: [func.(head) | map(tail,func) ]

  def sum([], total), 			do: total
	def sum([ head | tail ], total), do: sum(tail, head + total)
end
```

## The List Module in Action

list module:
```
# concatenate lists
#
iex> [1,2,3] ++ [4,5,6]
[1,2,3,4,5,6]
#
# Flatten
# 
iex> List.flatten([[[1], 2], [[[3]]]])
[1,2,3]
#
# Folding (like reduce, but can choose direction)
#
iex> List.foldl([1,2,3], "", fn value, acc -> "#{value}(#{acc})" end)
3(2(1()))
iex> @spec foldl([elem], acc, (elem, acc -> acc)) :: acc when elem: var, acc: var
iex> List.foldl([1,2,3,4], 0, fn(x, acc) -> x - acc end)
2
# x=1,acc=0			1 - 0 => acc = 1
# x=2,acc=1			2 - 1 => acc = 1
# x=3,acc=1			3 - 1 => acc = 2
# x=4,acc=2     4 - 2 => acc = 2    ==> result
iex> List.foldr([1,2,3], "", fn value, acc -> "#{value}(#{acc})" end)
1(2(3()))
#
# Merging lists and splitting them apart
#
iex> l = List.zip([[1,2,3], [:a,:b,:c], ["cat","dog"]])
[{1, :a, "cat"}, {2, :b, "dog"}]
iex> List.unzip(l)
[[1,2], [:a, :b], ["cat", "dog"]]
#
# Accessing tuples within lists
#
iex> kw = [{:name, "Dave"}, {:likes, "Programming"}, {:where, "Dallas","TX"}]

iex> List.keyfind(kw, "Dallas", 1)
{:where, "Dallas", "TX"}
iex> List.keyfind(kw, "TX", 2)
{:where, "Dallas", "TX"}
iex> List.keyfind(kw, "TX", 1)
nil
iex> List.keyfind(kw, "TX", 1, "No city called TX")
"No city called TX"
iex> kw = List.keydelete(kw, "TX", 2)
[name: "Dave", likes: "Programming"]
iex> kw = List.kereplace(kw, :name, 0, {:first_name, "Dave"})
[first_name: "Dave", likes: "Programming"]
```

