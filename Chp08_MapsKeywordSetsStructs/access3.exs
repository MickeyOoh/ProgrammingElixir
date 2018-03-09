cast = %{
  buttercup: %{
    actor:    {"Robin", "Wright"},
    role:     "princess"
  }, 
  westley: %{
    actor:    {"Carey",  "Elwes"},
    role:     "farm boy"
  }
}

IO.inspect get_in(cast, [Access.key(:westley), :actor, Access.elem(1)])

IO.inspect get_and_update_in(cast, [Access.key(:buttercup), :role],
                              fn (val) -> {val, "Queen"} end)
IO.puts ""
IO.puts "iex> Access.pop(%{name: \"Elixir\", creator: \"Valim\"}, :name)"
a1 = Access.pop(%{name: "Elixir", creator: "Valim"}, :name)
IO.inspect a1

IO.puts ""
IO.puts "iex> Access.pop([name: \"Elixir\", creator: \"Valim\"], :name)"
a2 = Access.pop([name: "Elixir", creator: "Valim"], :name)
IO.inspect a2

IO.puts ""
IO.puts "iex> Access.pop(%{name: \"Elixir\", creator: \"Valim\"}, :year)"
a3 = Access.pop(%{name: "Elixir", creator: "Valim"}, :year)
IO.inspect a3

