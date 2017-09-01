## Tasks and Agents
> #### We want to be able to run simple processes, either for background processing or for maintaining state. But we don't want to be bothered with the low-level details of _spawn_, _send_, and _receive_, and we really don't need the extra control that writing our own GenServer gives us.
> #### An Elixir task is a function that runs in the background.

tasks1.exs:
```tasks1.exs
defmodule Fib do
  def of(0), do: 0
	def of(1), do: 1
	def of(n), do: Fib.of(n-1) + Fib.of(n-2)
end

IO.puts "Start the task"
worker = Task.async(fn -> Fib.of(20) end)
IO.puts "Do something else"
#
IO.puts "Wait for the task"
result = Task.await(worker)

IO.puts "The result is #{result}"
``` 
* The call to Task.async creates a separate process that runs the given function.
* The return value of async is a task decriptor(actually a PID and a ref) that we'll use to identify the task later.
* Once the task is running, the code continues with other work.

### > elixir task1.exs


## Agents
> An agent is a background process that maintains state. This state can be accessed at different places within a process or node, or across multiple nodes.

> The initial state is set by a function we pass in when we start the agent.
> We can interrogate the state using _Agent>get_, passing it the agent descriptor and a function. The agent runs function on its current state and returns the result.
> We can also use _Agent.update_ to change the state held by an agent. As with the _get_ operator, we pass in a function. Unlike with _get_, the function's result becomes the new state.
 
> Here's a bare-bones example. We start an agent whose state is the integer 0.
> We then use the identity function ```&(&1)``` to return that state. Calling _Agent.update_ with ```&(&1+1)``` increments the state, as verified by a subsequent _get_.

example code: 
```
iex> { :ok, count} = Agent.start(fn -> 0 end)

iex> Agent.get(count, &(&1)
0
iex> Agent.update(count, &(&1+1))
:ok
iex> Agent.update(count, &(&1+1))
:ok
iex> Agent.get(count, &(&1))
2
```
> In this example, the variable _count_ holds the agent process's PID. We can also give agents a local or global name and access them using this name.
> In this case we exploit the fact that an uppercase bareword in Elixir is onverted into an atom with the prefix _Elixir_, so when we say Sum it is actually the atom _:Elixir.Sum_.
```
iex> Agent.start(fn -> 1 end, name: Sum)
{:ok, #PID<x.xx.x>}
iex> Agent.get(Sum, &(&1) )
1
iex> Agent.update(Sum, &(&1+99) )
:ok
iex> Agent.get(Sum, &(&1) )
100
```

## A Bigger Example anagrams.exs
code:
```
iex> c "anagrams.exs"

iex> Dictionary.start_link

iex> Enum.map(1..4, &"words/list#{&1}") |> WordlistLoader.load_from_files

iex> Dictionary.anagrams_of "organ"

["orang", "nagor",.......]

```

### Making it Distributed
  Because agents and tasks run as OTP servers, they can already be distributed.
	All we need to do is give our agent a globally accessible name. That's a oneline change:
```@name {:global, __MODULE__}```

> Window #1
```
$ iex --sname one anagrams_dist.exs
iex(one@MickeyMac)1>
iex(one@MickeyMac)2> Dictionary.start_link
{:ok, #PID<x.xx.x>}
iex(one@MickeyMac)3> WordlistLoader.load_from_files(~w{words/list1 words/list2})
[:ok, :ok]
iex(one@MickeyMac)4> Dictionary.anagrams_of "argon"
["ronga", "rogan", "orang",..................]
```
> Window #2
```
$ iex --sname two anagrams_dist.exs
iex(two@MickeyMac)1> Node.connect :one@MickeyMac
true
iex(two@MickeyMac)2> Node.list
[:one@MickeyMac]
iex(two@MickeyMac)3> WordlistLoader.load_from_files(~w{words/list3 words/list4})
[:ok, :ok]
iex(two@MickeyMac)2> Dictionary.anagrams_of "crate"
["recta", "react", "creta", .................]
```

