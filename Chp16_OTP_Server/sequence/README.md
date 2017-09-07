# Sequence

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `sequence` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:sequence, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/sequence](https://hexdocs.pm/sequence).

   When a client calls our server, GenServer invokes the *handle_call* function that follows. It receives
  * the informmation the client passed to the call as its first parameter,
  * the PID of the client as the second parameter,
  * and the server state as the third parameter.
  Our implementation is simple: we return a tuple of OTP.
    { :reply, current_number, current_number + 1 }
  The reply element tells OTP to reply to the client, passing back the value that is the second element. Finally the tuple's third element defines the new state.

## Execute Sequence.Server
```
$ iex -S mix
iex> { :ok, pid } = GenServer.start_link(Sequence.Server, 100)
{:ok, #PID<x.xx.x>}
iex> GenServer.call(pid, :next_number)
100
iex> GenServer.call(pid, :next_number)
101
iex> GenServer.cast(pid, {:increment_number, 299})
:ok
iex> GenServer.call(pid, :next_number)
302
```

#### Tracing a Server's Execution
  The third parameter to start_link is a set of options. A useful one during
	 development is the debug trace. which logs message activity to the console.
```
iex> {:ok, pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:trace]])
{:ok, #PID<x.xx.x>}
iex> GenServer.call(pid, :next_number)
*DBG* <x.xx.x> got call next_number from <x.xx.x>
*DBG* <x.xx.x> sent 100 to <x.xx.x>, new state 101
100
```
  We can also include :statistics in the debug list to ask a server to keep some basic statistics:
```
iex> {:ok, pid} = GenServer.start_link(Sequence,Server, 100, [debug: [:statistics]])
iex> GenServer.call(pid, :next_number)
100
iex> GenServer.call(pid, :next_number)
101
iex> :sys.statistics pid, :get
{:ok, [start_time: {{2013, 4, 26}, {18, 17,16}}, current_time: ....
iex> :sys.trace pid, true
:ok
iex> GenServer.call(pid, :next_number)
*DBG* <x.xx.x> got call next_number from <x.xx.x>
*DBG* ..............
105
iex> :sys.trace pid, false
:ok
iex> :sys.get_status pid

```
  This is the default formatting of the status message GEnServer provides. 
	You have the option to change the 'State' part to return a more application-specific message by defining format_status.
```
def format_status(_reason, [ _pdict, state]) do 
  [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
end
...
iex> :sys.get_status pid
{:status, .........
data: [{'State', "My current state is '103', and I'm happy"}] ]]}
```
### GenServer Callbacks
[callback](../GenServer/callbacks.html)

### last examine server.ex
```
$ iex -S mix
iex> Sequence.Server.start_link 123
{:ok, #PID<x.xx.x>}
iex> sequence.Server.next_number
123
iex> Sequence.Server.next_number
123
iex> Sequence.Server.increment_number 100
:ok
iex> Sequence.Server.next_number
225
```

