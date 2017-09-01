## GenServer Callbacks
  GenServer is an OTP protocol. OTP works by assming that your module deinfes a number of callback functions(six, in the case of a GenServer). 

1. *init(start_arguments)*
    Called by GenServer when starting a new server. The parameter is the 
		second argument passed to *start_link*. Should return {:ok, state} on success, or {:stopo, reason} if the server could not be started.
		You qn wp3diry qn optional timeout using {:ok, timeout}, in which case
		GenServer sends the process a :timeout message whenever no message is
		received in a span of timeout ms.
2. *handle_call(request, from, state)*
    invoked when a client uses GenServer.call(pid, request). the *form*
		parameter is a tuple containing the PID of the client and unique tag.
		The state prarmeter is the server state.
		On success returns {:reply, result, new_state}. 
3. *handle_cast(request, state)*
    Called in response to GenServer.cast(pid, request).
		A successful response is {:noreply, new_state}. Can also return 
		{:stop, reason, new_state}.
		The default implementation stops the server with a :bad_cast error.

4. *handle_info(info, state)*
    Called to handle incoming messages that are not call or cast requests.

5. *terminate(reason, state)*
    
6. *code_change(from_version, state, extra)*
    OTP lets us replace a runnin server without stopping the system. However
		the new version of the server may represent its state differently from
		the old version. 
7. *format_status(reason, [pdict,state])*
    Used to cutomize the state display of the server. The conventional
		response is [data: [{'State', stateinfo}]].

