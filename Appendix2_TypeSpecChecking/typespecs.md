Typespecs
-----
Elixir comes with a notation for declaring types and specifications. Elixir
is a dyanmically typed language, and as such, type specifications are never
used by the compiler to optimize or modify code. Still, using type
specifications is usefule because
* they procide documentation(for example, tools such as ExDoc show type
specifications in the documentation)
* they're used by tools such as Dialyzer, that can analyze code with typespec to find type inconsisitencies and possible bugs

Type specifications (sometimes referred to as typespecs) are defined in different contexts using the following attributes:
- @type
- @opaque
- @typep
- @spec
- @callback
- @macrocallback

Basic types
-----
```
type :: any()						# 
      | none()
			| atom()
			| map()
			| pid()
			| port()
			| reference()
			| struct()
			| tuple()
  ## Numbers
	    | float()
			| integer()
			| neg_integer()
			| non_neg_integer()
			| pos_integer()
	## Lists
	    | list(type)
			| nonempty_list(type)
			| maybe_improper_list(type1, type2)
			| nonempty_improper_list(type1, type2)
			| nonemtpy_maybe_improper_list(type1, type2)

      | Literals
			| Builtin
			| Remotes
			| UserDefined
```

