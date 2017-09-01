defmodule Sum do 
  def values(dict) do 
    #dict |> Dict.values |> Enum.sum
	  dict |> Map.values |> Enum.sum
	end
end

# Sum a HashDict
hd = [ one: 1, two: 2, three: 3] |> Enum.into(Map.new)
IO.puts Sum.values(hd)

map = %{ four: 4, five: 5, six: 6}
IO.puts Sum.values(map)

kw_list = [name: "Dave", likes: "Programming", where: "Dallas"]
hashdict = Enum.into kw_list, HashDict.new

map = Enum.into kw_list, Map.new

IO.puts kw_list[:name]
IO.puts hashdict[:likes]
IO.puts map[:where]
drop = Map.drop(map, [:where, :likes])
IO.puts inspect(drop)

mapput = Map.put(drop, :also_likes, "Ruby")
IO.puts inspect(mapput)

combo = Map.merge(mapput,map)
IO.puts inspect(combo)

kw_list = [name: "Dave", likes: "Programming", likes: "Elixir"]
IO.puts inspect(kw_list)
IO.puts kw_list[:likes]
#kw = Map.get(kw_list, :likes)
kw = Enum.into(kw_list, Map.new)
IO.puts "#{inspect(kw)} => #{Map.get(kw, :likes)}" 
key = Keyword.get_values(kw_list, :likes)
IO.puts inspect(key)


