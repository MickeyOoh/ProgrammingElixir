Elixir Basic
=====

Built-in Types
----
- Value types:
  - Arbitrary-sized integers
	- Floating-point numbers
	- Atoms
	- Ranges
	- Regular expressions
- System types:
  - PIDs and ports
	- References
- Collection types:
  - Tuples
	- Lists
	- Maps
	- Binaries

Atoms
Atoms are constants that represent something's name. We write them using a leading colon(:), which can be followed by an atom word or an Elixir operator.
An atom word is a sequence of letters, digits, underscores, and at signs(@). It may end with an exclamation point or a question mark. 
```
:fred  :is_binary? :var@2 :<> :=== :"func/3" :"long john silver"
```


* Binaries
  Sometimes you need to access data as a sequence of bits and bytes. For example, the headers in JPEG and MP3 files contain fields where a single byte may encode two or three separate values.
```
iex> bin = << 1, 2>>
<<1, 2 >>
iex> byte_size bin
2
iex> bin = <<3 :: size(2), 5 :: size(4), 1 :: size(2) >>
<<213>>
iex> :io.format("~-8.2b~n", :binary.bin_to_list(bin))
11010101
:ok
iex> byte_size bin
1
```
Binaries are both important and arcane. They're important because Elixir uses them to represent UTF strings.
They're arcane because, at least initially, you're unlikely to use them directly.

Operators
----

* Comparison 
```
a === b
a !== b
a == b
a != b
a  > b
a >= b
a <  b
a <= b
```
* Boolean 
```
a or b  
a and b
not a
```
* Relaxed Boolean operators
   These operators take arguments of any type. Any value apart from *nil* or *false* is interpreted as true.
```
a || b   # a if a is truthy, otherwise b
a && b   # b if a is truthy, otherwise a
!a
```

* Arithmetic 

`+ - * / div rem`

* Join 
```
bianry1 <> bianry2
list1 ++ list2
list1 -- list2
```
* the **in** operator

` a in enum`

Variable Scope
----
Elixir is lexically scoped. the basic unit of scoping is the function body.
Variables defined in a function (including its parameters) are local to that function. 
In addtion, modules define a scope for local variables, but these are only accesible at the top level of that module, and in functions defined in the module.

#### the with Expression
  The *with* expression serves double duby. First, it allows you to define a local scope for variables: if you need a couple of temporary variables when calculating something, and don't want  those variables to leak out into the wider scope.
	Second, it gives you some control over pattern matching failures.

![with-scope.exs](with-scope.exs)

The *with* expression lets us work with what are effectively temporary variables as we open the file, read its content, close it, and search for the line we want.
The value of the *with* is the value of its *do* parameter.

#### with and Pattern Matching
```
iex> with [a|_] <- [1,2,3], do: a
1
iex> with [a|_] <- nil, do: a
nil
```


