nested = %{
	buffercup: %{
   actor: %{
		 first: "Robin",
		 last: "Wright"
	}, 
	role: "princess"
},
  westley: %{
	  actor: %{
		  first: "Carey",
		  last: "Ewes"
	  }, 
	  role: "farm boy"
	}
}

IO.inspect get_in(nested, [:buffercup])

IO.inspect get_in(nested, [:buffercup, :actor])

IO.inspect get_in(nested, [:buffercup, :actor, :first])

