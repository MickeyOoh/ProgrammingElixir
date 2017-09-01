## When Processes Die
  Who gets told when a process dies? By default, no one. Obviously the VM 
	knows and can report it to the console, but your code will be oblivious unless you explicitly tell Elixir you want to get involved.
	Here's the default case: we spawn a function that uses the Erlang _timer_ library to sleep for 500ms. It then exits with a status of 99.
	'elixir -r link1.exs'

#### Linking Two Processes
  If we want two processes to share in each other's pain, we can link them.
	When processes are linked, each can receive information when the other exits. 
	The _spawn_link_ call spawns a process and links it to the caller in one operation.

'elixir -r link2.exs'
'elixir -r link3.exs'

  What if you want to handle the death of another process? You probably don't want to do this.
	Elixir uses the OTP framework for constructing process trees, and OTP includes the concept of process supervision.
	And you can tell Elixir to convert the exit signals from a linked process
	into a message you can handle. Do this by _trapping the exit_.
  The time we see an :EXIT message when the spawned process termintates:
```
$ elixir 0r link3.exs
MESSAGE RECEIVED: {:EXIT, #PID<xxxxx>, :boom}
```

1. Making process and send message
  you will disginates pid of sending and messaes.
```
child_pid = spawn(Hoge, :say, [])
send child_pid, {self, "World!"}
```
Self() will return back self pid.
  arguments:
  1. sending pid
	2. sending message
you will send your own pid and message string to child process.

2. Child process receives message and sends
```
def greet do 
  receive do    # waiting for receive from main process 
	  { sender, msg} ->
		    send sender, {:ok, "Hello #{msg}" }
  end
end
```
3. Receive message from main process
  Main process waits for message from child process.
```
receive do 
  {:ok, messgae} ->
	   IO.puts messsage
end
```


