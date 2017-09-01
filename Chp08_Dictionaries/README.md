## Dictionaries: Maps, HashDicts, Keywords, Sets, and Structs

### How to Choose Between Maps, HashDicts, and Keywords
* Will I want more than one entry with the same key? If so, you'll have to use the _Keyword_ module.
* Do I need to guarauntee the elements are ordered? If so, again, use the _Keyword_ module.
* Do I want to pattern-match against the contents(for example, matching a dictionary that has a key of _:name_ somewhere in it)? If so, use a map.
* Will I be storing more than a few hundred entries in it? If so, use a _HashDict_, With R17 of the BEAM virtual machine(which runs Erlang), maps are slow, particularly when adding new items. This should improve in R18.

## Pattern Matching and Updating Maps
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


