## Control Flow
  Try not to use them much. You definitely will, and should, drop the occasional _if_ or _case_ into your code. But consider more functional alternatives. The benifit will become obvious as you write more code--functions written without explicit control flow tend to be shorter and more focused.

* **if and unless**
```
iex> if 1 == 1, do: "true part", else: "false part"
"true part"
iex> if 1 == 2, do: "true part", else: "false part"
"false part"
iex> if 1 == 1 do
...>   "true part"
...> else
...>   "false part"
...> end
true part
iex> unless 1 == 1, do: "error", else: "OK"
"OK"
iex> unless 1 == 2, do: "OK", else: "error"
"OK"
```
* **cond**
> Elixir fizzbuzz.ex
> Elixir fizzbuzz1.ex
> Elixir fizzbuzz2.ex
> Elixir fizzbuzz3.ex
* **case**
> elixir case.ex
> elixir case1.exs
> elixir case2.exs

### Raising Exceptions
```
iex> raise "Giving up"
** (RuntimeError) Giving up
iex> raise RuntimeError
** (RuntimeError) runtime error
iex> raise RuntimeError, message: "override message"
** (RuntimeError) override message
##
# File.open  -> {:ok, file} or {:error, reason}
case File.open(user_file_name) do 
{:ok, file} ->
   process(file)
{:error, message} ->
   IO.puts :stderr, "Couldn't open #{user_file_name}: #{message}"
	  
end
```

