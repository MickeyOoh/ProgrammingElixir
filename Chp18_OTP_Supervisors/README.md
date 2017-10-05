## OTP:Supervisors
  The Elixir way says not to worry much about code that crashes; instead,
	make sure the overall application keeps running.
	This might sound contradictory, but really is not.
	If an unhandled error causes an exception to be raised, the application
	stops. Nothing else gets done until it is restarted.
	If it's a server handling multiple requests. they all might be lost.

  The issue here is that one error takes the whole application down.

	But imagine that instead your application consists of hundreds or thousands of processes, each handling just a small part of a request. If one of those crashes, everything else carries on. 

> OTP:Supervisors perform all of this process monitoring and restarting.

## Supervisors and Workers
  An Elixir supervisor has just one purpose - it manages one or more worker
	processes.
	It is given a list of processes to monitor and is told what to do if a
	process dies, and how to prevent restart loops (when a process is restarted, dies, gets restarted, dies, and so on).
	You can write supervisors as separate modules, but the Elixir style is to 
	include them inline. The easiest way to get started is to create your
	project with the *--sup* flag.
```
$ mix new --sup sequence
```

```sequence/application.ex
defmodule Sequence do 
  use Application

	def start(_type, _args) do 
	  import Supervisor.Spec, warn: false

		children = [
		   worker(Sequence.Server, [123])

		]

		opts = [strategy: :one_for_one, name: Sequence.Supervisor]
		{:ok, _pid} = Supervisor.start_link(children, opts)
	end
end
```
  Sequence of events:
  - When our application starts, the start function is called
	- It creates a list of child serers. It uses the worker function to createa specification of each one. In our case, we want to start Sequence.Server and pass it the parameter 123.
	- We call Supervisor.start_link, passing it the list of child specifications and a set of options. This creates a supervisor process.
	- Now  our supervisor process calls the start_link function for each of its managed children. In our case, this is the function in Sequence.Server. This code is unchanged - it calls GenServer.start_link to create a GenServer process.
``` 
$ iex -S mix
...
iex> Sequence.Server.increment_number 3
:ok
iex> Sequence.Server.next_number
126
iex> Sequence.Server.increment_number "cat"
:ok
iex> xx:xx:xx.xxx [error] GenServer Sequence.Server terminating
Last message: {:
...
iex> Sequence.Server.next_number
123
iex> Sequence.Server.next_number
124
```

### Managing Process State Across Restarts
  Some servers are effectively stateless. If we had a server that calculated
	the factors of numbers or responded to network requests with the current time, we could simply restart it and let it run.
	But our server is not stateless - it needs to remember the current number so it can generate an increasing sequence.


