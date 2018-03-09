IO.puts "iex> set1 = 1..5 |> Enum.into(MapSet.new)"
set1 = 1..5 |> Enum.into(MapSet.new)
IO.inspect set1

IO.puts "iex> set2 = 3..8 |> Enum.into(MapSet.new)"
set2 = 3..8 |> Enum.into(MapSet.new)
IO.inspect set2

IO.puts "iex> MapSet.member? set1, 3"
a1 = MapSet.member? set1, 3
IO.inspect a1

IO.puts ""
IO.puts "iex> MapSet.union set1, set2"
a2 = MapSet.union set1, set2
IO.inspect a2

IO.puts ""
IO.puts "iex> MapSet.difference set1, set2"
a3 = MapSet.difference set1, set2
IO.inspect a3

IO.puts "iex> MapSet.difference set2, set1"
a4 = MapSet.difference set2, set1
IO.inspect a4

IO.puts ""
IO.puts "iex> MapSet.intersection set2, set1"
a5 = MapSet.intersection set2, set1
IO.inspect a5




