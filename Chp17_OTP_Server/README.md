OTP:Servers, OTP:Supervisors, OTP:Applications
----
* OTP:Servers
  OTP is often hyped as the answer to all high-availability distributed-application woes. It isn't, but it certainly solves many problems that you'd otherwise need to solve yourself, including application discovery, failure detection and management, hot code swapping, and server structure.
	First, the obligatory one-paragraph history. OTP stands for the Open Telecom Platform, but the full name is largely of historical interest and everyone just says OTP. It was initially used to build telephone exchanges and switches.
	But these devices have the same characteristic we want from any large online application, so OTP is now a general-purpose tool for developing and managing large systems.
	OTP is actually a bundle that includes Erlang, a database(wonderfully called _Mnesia_), and an innumerable number of libraries. It also defines a structure for your applications. 

* Some OTP Definitions
  OTP defines systems in terms of hierarchies of **applications**.
	An application consists of one or more processes. These processes follow one of a small number of OTP conventions, called **behaviors**.
	There is a behavior used for general-purpose servers, one for implementing event handlers, and one for finite-state machines(FSM). 
	We'll be implementing the _sever_ behavior, called **GenServer**.

> OTP is an application operating system and a set of libraries and procedures used for building large-scale, fault-tolerant, distributed applicatoins.

> OTP is a domain-independent set of frameworks, principles, and patterns that guide and support the structure, design, implementation, and deployment of Erlang systems.

- Three Components of OTP
      - Erlang(semantics/virtual machine)
      - Tools/Libraries
      - System Design Principles

* An OTP Server
 When we wrote our Fibonacci server in the previous chapter, we had to do all the message handling ourselves. It wasn't difficult, but it was tedious. 
 Our scheduler also had to keep track of three pieces of state information:
    - the queue of numbers to process
		- the results generated so far
		- the list of active PIDs
	Most servers have a similar set of needs, so OTP provides libraries that do all the low-level work for us.
	
 When we write an *OTP server*, we write a module containing one or more callback functions with standard names.
 OTP will invoke the appropriate callback to handle a particular situation.
 For example, when someone sends a request to our serer, OTP will call our handle_call function, passing in the request, the caller, and the current server state.
 Our function responds by returning a tuple containing an action to take, the return value for the request, and an updated state.

 We're using two functions from the Elixir _GenServer_ module. The start_lik function behaves like the spawn_link function. It asks _GenServer_ to start a new process and link to us (so we'll get notifications if it fails).
  
```
def handle_call({:set_number, new_number}, _from, _current_number) do 
  { :reply, new_number, new_number }
end
iex> GenServer.call(pid, {:set_number, 999})
999
...
# Similarly, a handler can return multiple values by packaging them into a tuple or list.
def handle_call({:factors, number}, _, _) do 
  { :reply, { :factors_of, number, factors(number)}, [] }
end
 
