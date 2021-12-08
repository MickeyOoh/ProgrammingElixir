defmodule Testmaps do 
  def test1 do  
    map = %{ name: "Dave", likes: "Programming", where: "Dallas"}
    IO.puts "iex> map = %{ name: \"Dave\", likes: \"Programming\", where: \"Dallas\"}"
    IO.inspect map
    IO.puts "\niex> Map.keys map\n#{inspect Map.keys map}"
    IO.puts "\niex> Map.values map\n#{inspect Map.values map}"

    IO.puts "\niex> map[:name]\n#{inspect map[:name]}"
    IO.puts "\niex> map.name\n#{inspect map.name}"
    map1 = Map.drop map, [:where, :likes]
    IO.puts "\niex> map1 = Map.drop map, [:where, :likes]\n#{inspect map1}"

    map2 = Map.put map, :also_likes, "Ruby"
    IO.puts "\niex> map2 = Map.put map, :also_likes, \"Ruby\"\n#{inspect map2}"
    IO.puts "\niex> Map.keys map2\n#{inspect Map.keys map2}"
    IO.puts "\niex> Map.has_key? map1, :where\n#{inspect Map.has_key? map1, :where}"

    { value, updated_map } = Map.pop map2, :also_likes
    IO.puts "\niex> { value, updated_map } = Map.pop map2, :also_likes\n#{inspect { value, updated_map}}"

    IO.puts "\niex> Map.equal? map, updated_map\n#{inspect Map.equal? map, updated_map}"

  end

  def test2 do 
    IO.puts "Pattern Matching and updating Maps"
    IO.puts """
    Is there an entry with the key :name?
    """
    person = %{ name: "Dave", height: 1.88 }
    IO.puts "person = %{ name: \"Dave\", height: 1.88 }"
    %{name: a_name} = person
    IO.puts "iex> a_name\n#{a_name}"
    IO.puts """
    Are there entries for the keys :name and :height?
    """

    IO.puts "iex> %{name: _, height: _ } = person"
    %{name: _, height: _ } = person
    IO.puts "#{inspect person}"
    IO.puts """
    Does the entry with key :name have the value \"Dave\"?
    """
    IO.puts "iex> %{name: \"Dave\" } = person"
    %{name: "Dave" } = person
    IO.puts "#{inspect person}"
    
    IO.puts "iex> %{name: _, weight: _ } = person"
    %{name: _, weight: _ } = person

  end
end


Testmaps.test1

