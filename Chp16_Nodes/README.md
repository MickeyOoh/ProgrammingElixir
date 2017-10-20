# Nodes -- The Key to Distributing Services
>  There's nothing mysterious about a node. It is simply a running Erlang VM.throughout this book we've been running our code on a node.
>	The Erlang VM. called _Beam_, is more than a simple interpreter. It's like its own little operating system running on top of your host operating system. It handles its own events, process scheduling, memory, naming services, and interprocess communication.
>	A node can connect to other nodes--in the same computer, across a LAN, or across the Internet - and prvode many of the same services across these connections that it provides to the processes it hosts locally.


### Window #1
```
$ iex --sname node_one
iex(node_one@MickeyMac)1>
iex(node_one@MickeyMac)2> func = fn -> IO.inspect Node.self end
#Function<erl_eval.xxxxx>
iex(node_one@MickeyMac)3> spawn(func)
node_one@MickeyMac
#PID<xxx>
iex(node_one@MickeyMac)4> Node.spawn(:node_one@MickeyMac, func)
node_one@MickeyMac
#PID<xxxx>
iex(node_one@MickeyMac)5> Node.spawn(:node_two@MickeyMac, func)
#PID<xxxx>
node_two@MickeyMac
```
### Window #2
```
$ iex --sname node_two
iex(node_two@MickeyMac)1> Node.list
[]
iex(node_two@MickeyMac)2> Node.connect :"node_one@MickeyMac"
true
iex(node_two@MickeyMac)3> Node.list
[:node_one@MickeyMac]
```

#### Nodes, Cookies, and Security
  Although this is cool, it might also ring some alarm bells. If you can run
	arbitrary code on any node, then anyone with a publicly accessible node has
	just handed over his machine to any random hacker.
	But that's not the case. Before a node will let another connect, it checks that the remote node has permission. It does that by comparing that node's
	_cookie_ with its own cookie. A cookie is just an arbitary string(ideally
	fairly long and very random). As an administrator of a distributed Elixir
	system, you need to create a cookie and then make sure all nodes use it.
	You can pass in the cookie using the --cookie option.
### Window #1
```
$ iex --sname node_one --cookie cookie-one
iex(node_one@MickeyMac)> Node.connect :node_two@MickeyMac
false
```
### Window #2
```
iex --sname node_two --cookie cookie-two
iex(node_two@MickeyMac)1>
xx:xx:xx.xxx [error] ** Connection attempt from disallowed node :node_one@MickeyMac **
```

  The node that attempts to connect receives _false_, indicating the connection
	was not made. And the node that it tried to connect to logs an error describing
	the attempt.
	But why does it succeed when we don't specify a cookie? When Erlang starts, it looks for an _.erlang.cookie_ file in your home directory. If that file doesn't exist, Erlang creates it and stores a random string in it. It uses that string as the cookie for any node the user starts. That way, all nodes you start on a particular machine are automatically given access to each other.

## Naming Your Process
  Although a PID is displayed as three numbers, it contains just two fields
	  the first number     - the node ID
		the next two numbers - the low and high bits of the process ID
 When you run a process on your current node, its node ID will always be zero.
  However, when you export a PID to another node, the node ID is set to the number of the node on which the process lives.
	How can the callback find the generator in the first place? One way is for the generator to register its PID, giving it a name. The callbackk on the other node can look up the generator by name, using the PID that comes back to send messages to it.

  We define a start function that spawns the server process. It then uses :global.register_name to register the PID of this server under the name :ticker.
	Client who want to register to receive ticks call the register function.
	This function sends a message to the Ticker server, asking it to add those clients to its list.

## IO, PIDs, and Nodes
>  input and output in the Erlang VM are performed using I/O servers. These are simply Erlang processes that implement a low-level message interface.
>	You never have to deal with this interface directly(which is a good thing, as it is complex). Instead, you use the varous Elixir and Erlang I/O libraries and let them do the heavy lifting.

Elixir's IO.puts:
```
  def puts(device \\ group_leader(), item) do 
      erl_dev = map_dev(device)
      :io.put_chars erl_dev, [to_iodata(item), ?\n]
  end
```

  The default device it uses is returned by the function :erlang.group_leader. (The group_leader function is imported from the :erlang module at the top of the IO module.) This will be the PID of an I/O server.
  So, bring up two terminal windows and start a different named node in each.
	Connect to node one from node two, and register the PID returned by group_leader under a global name(we use :two).
## Window #1
```
$ iex --sname one
iex(one@MickeyMac) >
...
iex(one@MickeyMac) > two = :global.whereis_name :two
#PID<xxx.xx.xx>
iex(one@MickeyMac) > IO.puts(two, "Hello")
:ok 
iex(one@MickeyMac) > IO.puts(two, "World!")
:ok 
```
## Window #2
```
$ iex --sname two
iex(two@MickeyMac) > Node.connect(:one@MickeyMac)
true
iex(two@MickeyMac) > :global.register_name(:two, :erlang.group_leader)
:yes
...
Hello
World!
iex(two@MickeyMac) >
```	


Connecting nodes on different machines
-----
```
# Machine 1
$ iex --name foo@192.168.2.202 --cookie chocolate
iex(foo@192.168.2.202)> Node.ping :"bar@192.168.2.16"
:pong    # returns :pang if ping failed
iex(foo@192.168.2.202)> Node.list
[:"bar@192.168.2.16"]

# Machine 2
$ iex --name bar@192.168.2.16 --cookie chocolate
iex(bar@192.168.2.16)> Node.list
[:"foo@192.168.2.202"]
```



```
