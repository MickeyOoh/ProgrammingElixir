Dictionaries: Maps, HashDicts, Keywords, Sets, and Structs
----

How to Choose Between Maps, HashDicts, and Keywords
----
* Do I want to pattern-match against the contents (for example, matching a dictionary that has a key of *:name* somewhere in it)?
   if so, use a **map**
* Will I want more than one entry with the same key?
   If so, you'll have to use the **Keyword** module.
* Do I need to guarauntee the elements are ordered?
   If so, again, use the **Keyword** module.
* And, if you've reached this point:
  Use a **map**

Keyword Lists
----
 Keyword lists typically used in the context of options passed to functions.

![keywords.exs](keywords.exs)

For simple access, you can use the access operator. *kwlist[key]*. In addition, all the functions of the *Keyword* and *Enum* modules are available.

Maps
----
Maps are the go-to key/value data structure in Elixir. They have good performance at all sizes.
```
iex(1)> map = %{ name: "Dave", likes: "Programming", where: "Dallas" }
%{likes: "Programming", name: "Dave", where: "Dallas"}
iex(2)> Map.keys map
[:likes, :name, :where]
iex(3)> Map.values map
["Programming", "Dave", "Dallas"]
iex(4)> map[:name]
"Dave"
iex(5)> map.name
"Dave"
iex(6)> map1 = Map.drop map, [:where, :likes]
%{name: "Dave"}
iex(7)> map2 = Map.put map, :also_likes, "Ruby"
%{also_likes: "Ruby", likes: "Programming", name: "Dave", where: "Dallas"}
iex(8)> Map.keys map2
[:also_likes, :likes, :name, :where]
iex(9)> Map.has_key? map1, :where
false
iex(10)> { value, updated_map } = Map.pop map2, :also_likes
{"Ruby", %{likes: "Programming", name: "Dave", where: "Dallas"}}
iex(11)> Map.equal? map, updated_map
true
```

Pattern Matching and Updating Maps
----
> common question : "Do you have the following keys(and maybe values)?"

* Is there an tnry with the key _:name_?
* Are there entries for the keys _:name_ and _:height_?
* Dose the tnry with key _:name_ ahve the value "Dave"?

code:
```
iex> person = %{ name: "Dave", height: 1.88}
%{height: 1.88, name: "Dave"}
iex> %{name: a_name } = person
%{height: 1.88, name: "Dave"}
iex> a_name
"Dave"
iex> %{ name: _, height: _} = person
%{height: 1.88, name: "Dave"}
iex> %{ name: "Dave" } = person
%{height: 1.88, name: "Dave"}
iex> %{ name: _, weight: _ } = person
** (MatchError) no match of right hand side value: -------
```

#### Pattern Matching Can't Bind Keys
code: 
```
iex> %{ 2 => state } = %{ 1 => :ok, 2 => :error }
%{1 => :ok, 2 => :error}
iex> state
:error

iex> %{item => :ok } = %{ 1 => :ok, 2 => :error }
** (CompileError) iex:xx: illegal use of variable item in map key
```

## Updating a Map
> new_map = %{ old_map | key => value, ... }
code: 
```
iex> m = %{ a: 1, b: 2, c: 3}
%{ a: 1, b: 2, c: 3 }
iex> m1 = %{ m | b: "two", c: "three" }
%{a: 1, b: "two", c: "three" }
iex> m2 = %{ m1 | a: "one" }
%{a: "one", b: "two", c: "three" }
```

Structs
-----
When Elixir sees %{...} it knows it is looking at a map. But it doesn't know much more than that. In particular, it doesn't know what you intend to do with the map, whether ony certain keys are allowed, or whether some keys should have default values.
A struct is just a module that wraps a limited form of map. It's limited beause the keys must be atoms and because these maps doesn't have Dict capabilities.

A struct is just a module that wraps a limited form of map. It's limited because the keys must be atoms and because these maps don't have *Dict* capablilities.
The  name of the module is the name of the map type. Inside the module, you use the defstruct macro to define the struct's members.





## Warning of "defstruct" function
> You cannot use the struct in the same context it is defined. If you split the definition and usage into separates files it will work.

## Problem: Error Access OTP library
#### (ArgumentError) Access is not a protocol, cannot derive Access for At
#### When I check derive.exs
code:
```
defmodule Attendee do 
  
end
```
#### Strange issue occurred. _put_in_ or _update_in_ does not change value in the report.
```
iex> c "nested.exs"

iex> report = %Nested.BugReport{owner: %Nested.Customer{name: "Dave", company: "Pragmatic"}, details: "broken"} 
%Nested.BugReport{details: "broken",
 owner: %Nested.Customer{company: "Pragmatic", name: "Dave"}, severity: 1}

iex> put_in(report.owner.company, "PragProg")
 %Nested.BugReport{details: "broken",
  owner: %Nested.Customer{company: "PragProg", name: "Dave"}, severity: 1}

iex> inspect(report)
	"%Nested.BugReport{details: \"broken\", owner: %Nested.Customer{company: \"Pragmatic\", name: \"Dave\"}, severity: 1}"
```
result: we cannot change "Progmatic" to "PragProg".

|                   |  Macro       | Function          | 
|-------------------|--------------|-------------------|
| get_in            | (path,value) | (dict,keys)       | 
| put_in            | (path,fn)    | (dict,keys,value) | 
| update_in         | (path,fn)    | (dict,keys,fn)    | 
| get_and_update_in | (path,fn)    | (dict,keys,fn)    | 

#### Sets  ==>  MapSet
```
iex> set1 = Enum.into 1..5, MapSet.new
#MapSet<[1, 2, 3, 4, 5]>
iex> MapSet.member? set1, 3
true
iex> set2 = Enum.into 3..8, MapSet.new
#MapSet<[3, 4, 5, 6, 7, 8]>
iex> MapSet.union set1, set2
#MapSet<[1, 2, 3, 4, 5, 6, 7, 8]>
iex> MapSet.difference set1, set2
#MapSet<[1, 2]>
iex> MapSet.difference set2, set1
#MapSet<[6, 7, 8]>
iex> MapSet.intersection set1, set2
#MapSet<[3, 4, 5]>

```


