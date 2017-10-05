Modules and Named Functions
----

Guard Cluses
----
We've seen that pattrn matching allows Elixir to decide which function to invoke based on the arguments passed. But what if we need to distinguish based on their types or on some test involving their values? For this, you use *guard cluases*. These are predicates that are attached to a function definition using one or more *when* keywords.
```guard.exs
defmodule Guard do 
  def what_is(x) when is_number(x) do 
	  IO.puts "#{x} is a number"
	end
	def what_is(x) when is_list(x) do 
	  IO.puts "#{inspect(x)} is a list}"
	end
	def what_is(x) when is_atom(x) do 
	  IO.puts "#{x} is an atom"
	end
end

Guard.what_is(99)    # => 99 is a number
Guard.what_is(:cat)  # => cat is an atom
Guard.what_is([1,2,3]) # => [1,2,3] is a list
```

Guard-Clause Limitations
 - comaparison operators
    - ==. !=, ===, !==, >, <, <=, >=
 - Boolean and negation operators
    - or, and, not, !.   Note: || and && are not allowed
 - Arithmetic operators
    - <> and ++, as long as the left side is a literal
 - The in operator
    - Membershop in a collection or range
 - Type-check functions
    - is_atom, is_binary, is_bitstring, is_boolean, is_exception, is_function, is_integer, is_list, is_map, is_number, is_pid, is_record, is_reference, is_tuple
 - Other functions
    - abs(number)
    - bit_size(bitstring)
    - byte_size(bitstring)
    - div(number, number)
    - elem(type, n)
    - float(term)
    - hd(list)
    - length(list)
    - node(), node(pid|ref|port)
    - rem(number, number)
    - round(number)
    - self()
    - tl(list)
    - trunc(number)
    - tuple_size(tuple)

Default Parameters
----

When you define a named function, you can give a default value to any of its parameters by using the syntax **parm \\ value**.

code: 
```
defmodule Exmaple do 
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do 
    IO.inspect [p1, p2, p3, p4]
  end
end

Example.func("a","b")			 			# => ["a", 2, 3, "b"]
Example.func("a","b","c")    		# => ["a","b", 3, "c"]
Example.func("a","b","c","d")  	# => ["a","b","c","d"]
```

## The Amazing **Pipe** Operator
code: 
```
people = DB.find_customers
orders = Orders.for_customer(people)
tax    = sales_tax(orders, 2013)
filing = prepare_filing(tax)
```
Bread-and-Butter programming.
 
`filing=prepare_filing(sales_tax(Orders.for_customers(DB.find_customers), 2013))`

Then now 
```
filing = DB.find_customers
          |> Orders.for_customers
          |> sales_tax(2013)
          |> prepare_filing
```

Modules
-----
![](modulesdef.exs)


Module nesting in Elixir is an illusion-- all modules are defined at the top level.
When we define a module inside another. Elixir simply prepends the outer module name to the inner module name, putting a dot between the two.
This means we can directly define a nested module.

```
defmodule Mix.Tasks.Doctest do 
  def run do
	end
end
Mix.Tasks.Doctest.run
```
It also means there's no particular relationship between the module Mix and Mix.Tasks.Doctest.

#### Directives for Modules
Elixir has three directives that simplify working with modules. All three are executed as your porgram runs, and the effect of all three is *lexically scoped* -- it starts at the point the directive is encountered, and stops at the end of the enclosing scope. 
- import
- alias
- require 

##### The import Directive
The *import* directive brings a module's functions and/or macros into the current scope.
If you use a particular module a lot in your code, *import* can cut down the clutter in your source files by eliminating the need to repeat the module name time and again.
```
defmodule Example do 
  def func1 do 
	  List.flatten [1, [2, 3], 4]
	end
	def func2 do 
	  import List, only: [flatten: 1]
	  flatten [5, [6, 7], 8]
	end
end
```
*func1 List.flatten, but func2 flatten after import*

> import Module [, only:|except: ]

##### The alias Directive
```
defmodule Example do 
  def func do 
	  alias Mix.Tasks.Doctest, as: Doctest
		doc = Doctest.setup
		doc.run(Doctest.defaults)
	end
end
```

##### The require Directive
You require a module if you want to use the macros defined in that module.
The *require* directive ensures that the given module is loaded before your code tries to use any of the macros it defines.

Module Attributes
-----
Elixir modules each have associated metadata. Each item of metadatais called an attribute of the module and is identified by a name. Inside a module, you can access these attributes by prefixing the name with an t sign (@).

`@name value`

```
defmodule Example do 
  @author "Dave Thomas"
	def get_author do 
	  @author
	end
end

IO.puts "Example was written by #{Example.get_author}"
```
You can set the **same attribtue multiple times in a module**. 
If you access that attribute in a named function in that module, the vlaue you see will be the value in effect when the function is defined
```
defmodule Example do 
  @attr "one"
	def first, do: @attr
	@attr "two"
	def second, do: @attr
end

IO.puts "#{Example.first} #{Example.second}"
```

Module Names: Elixir, Erlang, and Atoms
-----
When we write modules in Elixir, they have names such as *String* or *PhotoAlibum*. We call functions in them usning calls such as *String.length("abc")*.
What's happening here is subtle. Internally, module names are just atoms.
When you write a name starting with an uppercase letter, such as *IO*, Elixir converts it internally into an atom called *Elixir.IO.*

```
iex> is_atom IO
true
iex> to_string IO
"Elixir.IO"
iex> :"Elixir.IO" === IO
true

iex> IO.puts 123
123
:ok
iex> :"Elixir.IO".puts 123
123
:ok
```

Calling a Function in an Erlang Library
----
The Erlang conventions for names are different --- variables start with an uppercase letter and atoms are simple lowercase names. 
So, for example, the Erlang module *timer* is called jsut that, the atom *timer*. In Elixir we write that as *:timer*. 

Say we want to output a floating-point number in a three-character-wide field with one deciaml place. Erlang has a function for the followings. A search for erlang format takes us to the description of the format function in the Erlang io module.
```
iex> :io.format("The number is ~3.1f~n", [5.678])
The number is 5.7
:ok
```


