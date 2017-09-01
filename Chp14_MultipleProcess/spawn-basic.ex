defmodule SpawnBasic do 
  def greet do 
    IO.puts "Hello"
  end
end
IO.puts "execute SpawnBasic.greet"
SpawnBasic.greet
IO.puts "execute 'spawn(SpawnBasic, :greet, [])'"
spawn(SpawnBasic, :greet, [])

