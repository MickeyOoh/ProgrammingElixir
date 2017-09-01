## OTP:Application
  OTP comes from the Erlang world, it uses Erlang names for things.
	And unfortunately, some of these names are not terribly descriptive.
	The name _application_ is one of these.
	An application is a bundle of code that comes with a descriptor. That
	descriptor tells the runtime what dependencies the code has, what global
	names it registers, and so on.
	an OTP application is more like a dynamic link library or a hared object than a conventional application.
	Applications are components; but here are some applications that are at the top of the tree and are meant to be run directly.

### The Application Specification File
  mix will talk about a file called _name.app_, where name is your application's name.
	This file is called an _application specification_ and is usd to define your application to the runtime environment. Mix creates this file automatically from the information in _mix.exs_ combined with information it gleans from compiling your application.
	 
### Turning Our Sequence Program into an OTP Application
	When mix created the initial project tree, it added a supervisor ( which we then modified) and enough information to our *mix.exs* file to get the application started. it filled in the _application_ function:
```
def application do 
  [mod: { Sequence.Application, [] }]		
	# Elixir 1.5 we need to add .Application /lib/sequence/application.ex
end
```
  In our previous version of the start function, we ignored the arguments
	and instead hard_wired the call to _start_link_ to pass 123 to our application. Let's cahnge that to take the value from _mix.exs_ instead.
	First, change _mix.exs_ to pass an initial value (we'll use 456):
```
def application do 
  [mod: { Sequence.Application, 456 } ]
end
# /lib/sequence/application.ex
defmodule Sequence do 
  use Application
	def start(_type, initial_number) do 
	  Sequence.Supervisor.start_link(initial_number)
	end
end
```

**mod:** option tells OTP the module that is the main entry point for our app.
 If our app is a conventional runnable application, then it will need to start applications may need to be initialized.
   For the sequence app, we tell OTP that the _Sequence_ module is the main entry point. OTP will call this module's _start_ function when it starts the application.
	 The second element of the tuple is the parameter to pass to this function.
The **registered:** option lists the names that our application will register. We can use this to ensure each name is unque across all loaded applications in a node or cluster. In our case, the sequence server registers itself under the name _Sequence.Server_, so we'll update the configuration to read as follows:
```mix.exs
# Configuration for the OTP application
def application do 
  [
	  mod: { Sequence, 456 },
		registered: [ Sequence.Server :
	]
end
```
"$ mix compile"

And look at the **sequence.app** that was generated 
```_build/dev/lib/sequence/ebin/sequence.app
{application,sequence,
					[{description, "sequence"},
					 {mod, {'Elixir.Sequence', []}},
```
### More on Application Parameters
```
def application do 
  [
	  mod: 			{ Sequence.Application, []},
		env:			[initial_number  456],
		registered:  [ :sequence ]
	]
end

# lib/application.ex
defmodule Sequence.Application do 
  use Application
	def start(_type, _args) do 
	  Sequence.Supervisor.start_link(Application.get_env(:seqeunce, :initial_number))
	end
end
```
### Hot Code-Swapping
  OTP release management is complex. Something with the potential to deal
	with dependencies between thousands of processes on hundreds of machines with tens of thousands of modules will, by its nature, be bigger than a breadbox.
	First, the real deal is not swapping code, but rather swapping code simply means starting a process with the new code and then sending messages to it.
	OTP provides a standard server callback that lets a server inherit the state from a prior version of itself.

