Anonymous Functions
-----

```
fn 
  parameter-list -> body
	prarmeter-list -> body ..
end
```
Think of fn...end as being a bit like the quotes that surround a string literal, except here we're returning a function as a value, not a string. We can pass that function value to other functions. We can also invoke it, passing in arguments.

```
iex> sum = fn (a,b) -> a + b end
#Function....
iex> sum.(1, 2)
3
```

One Function, Multiple Bodies
-----

```
iex> handle_open = fn
...>   {:ok,file} -> "Read data: #{IO.read(file, :line)}"
...>   {_, error} -> "Error: #{:file.format_error(error)}"
...> end

iex> handle_open.(File.open("code/intro/hello.exs"))
"Read data: xxxxxx"
iex> handle_open.(File.open("nonexistent"))
"Error: no such file or directory"
```


Functions Can Return Functions
----

```
iex> fun1 = fn -> fn -> "Hello" end end
...> fun1.()
...> fun1.().()
"Hello"

fun1 = fn ->
          fn ->
					   "Hello"
					end
			end
```


