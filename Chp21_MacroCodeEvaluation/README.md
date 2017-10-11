Macros and Code Evaluation chapter 20
-----
  Have you ever felt frustrated that a language didn't have just the right
	feature for some code you were writing? Or have you found your self repeating chunks of code that weren't amenable to factoring into functions? Or have you just wished you could program closer to our problem domain? 
	Then you need **Macro**
	Warning: Macros can easily make your code harder to understand, because you're essentially rewriting parts of the language.

> Never use a macro when you can use a function.

Implementing an if Statement
----
  if statement goes around like this:

```
myif <<condition>> do 
  <<evaluate if true>>
else
	<<evaluate if else>>
end
or
myif <<condition>>,
do:   <<evaluate if true>>,
else: <<evaluate if false>>
```
try to implement _myif_ as a function:
```my.exs:
defmodule My do 
  def myif(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    
    case condition do 
      val when val in [false, nil]
          -> else_clause
      _otherwise
          -> do_clause
    end
  end
end
```
When we run it, we're surprised to get the following output:
```
$ iex my.exs
....
iex> My.myif 1==2, do: (IO.puts "1 == 2"), else: (IO.puts "1 != 2")
1 == 2     #=> Before calling myif, do: and else: clauses are evaluated.
1 != 2		
:ok
```

When we call the _myif_ function, Elixir has to evaluate all of its parameters before passing them in. So both the _:do_ and _:else_ clauses are evaluated, and we see their output. Because IO.puts returns :ok on success, what actually gets passed to myif is
```myif 1==2, do: :ok, else: :ok```
This is why the final return value is :ok
Clearly we need a way of **delaying the execution of these clauses**. And **this is where macros come in**. But before we implement our _myif_ macro, we need a little background.

Macros Inject Code
----
  Let's pretend we're the Elixir compiler. We read a module's source top to
	bottom and generate a representation of the code we find. That representation is a nested Elixir tuple.
  If we want to support macors, we need a way to tell the compiler that we'd
	like to manipulate a part of that tuple.
>	 **defmacro**, **quote**,  **unquote**
> When we pass parameters to a macro, Elixir doesn't evaluate them. Instead, it passes them as tuples representing their code. We can examine this behavior using a simple macro definition that prints out its parameter.

### Load Order
You may be wondering about the struture of the preceding code. We put the macro definition in one module, and the usage of that macro in another. And that second module included a _require_ call.
Macros are expanded before a program executes, so the macro defined in one module must be available as Elixir is compiling another module that uses those macros.
The **require** tells Elixir to ensure the named module is compiled before the current one. In practice it is used to make the macros defined in one module available in another.
But the reason for the two modules is less clear. It has to do with the fact that Elixir first compiles source files and then runs them.
 
### The Quote Function
 We've seen that when we pass parameters to a macro they are not evaluated.
 The language comes with a function, **quote**, that also forces code to remain in its unevaluated form. **quote** takes a block that returns the internal representation of that block.
```
iex> quote do: :atom
:atom
iex> quote do: 1
1
iex> quote do: 1.0
1.0
iex> quote do: [1,2,3]
[1,2,3]
iex> quote do: "binaries"
"binaries"
iex> quote do: {1, 2}
{1,2}
iex> quote do: [do: 1]
[do: 1]
iex> quote do: {1,2,3,4,5}
{:"{}",[],[1,2,3,4,5]}
iex> quote do: (a = 1; a + a)
{:__block__, [], 
   [{:=, [], [{:a, [], Elixir}, 1]},
	  {:+, [context: Elixir, import: Kernel],
		 [{:a, [], Elixir}, {:a, [], Elixir}] } ] }
iex> quote do: [ do: 1 + 2, else: 3 + 4]
[do: {:+, [context: Elixir, import: Kernel], [1, 2]},
 else: {:+, [context: Elixir, import: Kernel], [3, 4]}]
```
When we write "abc", we create a binary containing a string. The double quotes say "interpret what follows as a string of characters and return the appropriate representation."
**quote** is the same: it says "interpret the content of the block that follows as code, and return the internal representation."


Using the Representation As Code
-----
When we extract the internal representation of some code, we stop Elixir from adding it automatically to the tuples of code it is building furing compilation -- we've effectively created a free-standing esland of code. How do we inject that code back into our program's internal representation?
Two ways.
First - the macro. Just like with a function, the value a marco returns is the last expression evaluated in that macro. That expression is expected to be a fragment of code in Elixir's internal representation. But Elixir does not return this represenation to the code that invoked the macro.
Instead it injects the code back into the internal representation of our porgram and returns to the caller the result of _executing_ that code. But that execution takes place only if needed.

We can demonstrate this in two steps. First,here's a macro that simply returns its parameter. The code we give it when we invoke the macro is passed as an internal representation, and when the macro returns that code, that represenation is injected back into the compile tree.

![eg.exs](eg.exs)
```
{{:., [line: 10], [{:__aliases__, [counter: 0, line: 10], [:IO]}, :puts]},
 [line: 10], ["hello"]}
 hello
```
Now we'll change that file to return a different piece of code. We use quote to generate the internal form:

![eg1.exs](eg1.exs)
```
{{:., [line: 10], [{:__aliases__, [counter: 0, line: 10], [:IO]}, :puts]},
 [line: 10], ["hello"]}
 Different code
```
Even though we passed IO.puts("hello") as a parameter. It was never executed by Elixir.
Instead, it ran the code fragment we returned using quote.


The Unquote Function
----
Let's get two things out of the way. First, we can use _unquote_ only inside a quote block. Second, _unqoute_ is a silly name. It should really be something like *inject_code_fragment*.
```
defmacro macro(code) do 
  quote do 
	  IO.inspect(code)
	end
end
```
When we run this, it reports an error:
** (CompileError) ..../eg2.ex:11: function code/0 undefined

Inside the quote block, Elixir is just passing regular code, so the name code is inserted literally into the code fragment it returns. But we don't want that.
We want to Elixir to insert the evaluation of the code we pass in. And that's where we use **unquote**. It temporarily turns off quoting and simply injects a code fragment into the sequence of code being returned by _quote_.
```
defmodule My do 
  defmacro macro(code) do 
	  quote do 
		  IO.inspect(unquote(code))
		end
	end
end
```
Inside the _quote_ block, Elixir is busy parsing the code adn generating its internal representation. But when it hits the _unquote_, it stops parsing and simply copies the code parameter into the generated code. After unqoute, it goes back to regular parsing.

There's another way of thinking about this.Using unquote inside a quote is a
way of deferring the execution of the unquoted code. It doesn't run when the
quote block is parsed.

### Back to Our myif Macro
```
defmodule My do
  defmacro if(condition, clauses) do 
	  do_clause   = Keyword.get(clauses, :do, nil)
		else_clause = Keyword.get(clauses, :else, nil)
		quote do 
		  case unquote(condition) do 
			  val when val in [false, nil]  -> unquote(else_clause)
				_                             -> unquote(do_clause)
			end
		end
	end
end
defmodule Test do
  require My
	My.if 1==2 do
	  IO.puts "1 == 2"
	else
		IO.puts "1 != 2"
	end
end
```
  The _if_ macro receives a condition and a keyword list. The condition and
any entries in the keyword list are passed as code fragments.
The macro extracts the _do:_ and/or _else:_ clauses from that list. It is then ready to generate the code for our _if_ statement, so it opens a _quote_ block. That block contains an Elixir _case_ expression. This case expression has to evaluate the condition that is passed in, so it uses _unquote_ to inject that condition's code as its parameter.
When Elixir executes this case statement, it evaluates the condition. At that point, _case_ will match the first caluse matches, we want to execute the code that was passed in either the _do:_ or _else:_ values in the keyword list, so we use _unquote_ again to inject that code into the _case_.

Using Bindings to Inject Values
----
Remember that there are two ways of injecting values into quoted blocks.
One is _unquote_. The other is to use a binding. However, the two have different uses and different semantics.
A binding is simply a keyword list of variable names and their values. When
we pass a binding to _quote_ the variables are set inside the body of that quote.
This is useful because macros are executed at compile time. This means they don't have access to values that are calculated at runtime.

We try this out using something like *mydef(:some_name)*. Sure enough, that
defines a function that, when called, returns *:some_name*.

```
defmodule My do 
  defmacro mydef(name) do 
    quote do
	    def unquote(name)(), do: unquote(name)
	  end
  end
end

defmodule Test do 
  require My
	[ :fred, :bert ] |> Enum.each(&My.mydef(&1))
end

IO.puts Test.fred
```
macro_no_binding.exs:12: invalid syntax in def x1()

At the time the macro is called, the each loop hasn't yet executed, so we
have no valid name to pass it. This is where bindings come in:

```macro_binding.exs
defmodule My do
  defmacro mydef(name) do 
	  quote bind_quoted: [name: name] do 
		  def unquote(name)(), do: unquote(name)
		end
	end
end
defmodule Test do 
  require My
	[ :fred, :bert ] |> Enum.each(&My.mydef(&1))
end

IO.puts Test.fred			#=> fred
```
Two things happen here.
First: the binding makes the current value of *name* available inside the body of the quoted block.
Second: the presence of the *bind_quoted:* option automatically defers the execution of the *unquote* calls in the body.
This way, the methods are defined at runtime.

As its name implies, *bind_quoted* takes a quoted code fragment. Simple things such as tuples are the same as normal and quoted code, but for most values you probably want to quote them or use *Macro.escape* to ensure that your code fragment will be interpreted correctly.

Macros Are Hygienic
----
  It is tempting to think of macros as some kind of textual subsitution
	a macro's body is expanded as text and then compiled at the point of call.But that's not the case.

![hygiene.ex](hygiene.ex)

Other Ways to Run Code Fragments
----
We can use the function *Code.eval_quoted* to evaluate code fragments, such as those returned by _quote_.
```
iex> fragment = quote do: IO.puts("hello")
{{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["hello"]}
iex> Code.eval_quoted fragment
hello
{:ok,[]}
```
By default, the quoted fragment is hygienic, and so does not have access to variables outside its scope. Using var!(:name), we can disable this feature and allow a quoted block to access variables in the containing scope. 
```
iex> fragment = quote do: IO.puts(var!(a))
{{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [],
 [{:var!, [context: Elixir, import: Kernel], [{:a, [], Elixir}]}]}
iex> Code.eval_quoted fragment, [a:, "cat"]
cat
{:ok,[a: "cat"]}
```
*Code.string_to_quoted* converts a string containing code to its quoted form, and *Macro.to_string* converts a code fragment back into a string.
```
iex> fragment = Code.string_to_quoted("defmodule A do def b(c) do c+1 end end")
{:ok,
 {:defmodule, [line: 1],
   [{:__aliases__, [counter: 0, line: 1], [:A]},
	    [do: {:def, [line: 1],
			     [{:b, [line: 1], [{:c, [line: 1], nil}]},
					       [do: {:+, [line: 1], [{:c, [line: 1], nil}, 1]}]]}]]}}
iex> Macro.to_string(fragment)
"{:ok, defmodule(A) do\n  def(b(c)) do\n    c + 1\n  end\nend}"
```
We can also evaluate a string directly using *Code.eval_string*.
```
iex> Code.eval_string("[a, a*b, c]", [a: 2, b: 3, c: 4])
{[2, 6, 4], [a: 2, b: 3, c: 4]}
```
### Macros and Operators
(This is definitely dangerous ground.)
We can override the unary and binary operators in Elixir using macros. to do so, we need to remove any existing definition first.

For example, the operator + is defined in the _Kernel_ module. to remoe the _Kernel_ definition and substitute our own, we'd need to do something like th following.
```operators.ex
defmodule Operators do 
  defmacro a + b do 
	  quote do
		  to_string(unquote(a)) <> to_string(unquote(b))
		end
	end
end
defmodule Test do 
  IO.puts(123 + 456)				#=> "579"
	import Kernel, except: [+: 2]
	import Operators
	IO.puts(123 + 456)			  #=> "123456"
end

IO.puts(123 + 456)				  #=> "579"
```

the Macro module has two functions that list the unary and binary operators:
```
iex> require Macro
Macro
iex> Macro.binary_ops
[:===, :!==, :==, :!=, :<=, :>=, :&&, :||, :<>, :++, :--, :\\, :::, :<-, :..,
 :|>, :=~, :<, :>, :->, :+, :-, :*, :/, :=, :|, :., :and, :or, :when, :in, :~>>,
  :<<~, :~>, :<~, :<~>, :<|>, :<<<, :>>>, :|||, :&&&, :^^^, :~~~]
iex> Macro.unary_ops
[:!, :@, :^, :not, :+, :-, :~~~, :&]
```
## AST (abstract syntax tree, 抽象構文木)
## DSL (domain-specific language)

