defmodule Frequency do 

  def start_link do 
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end
  def add_word(word) do 
    Agent.update(__MODULE__,
                 fn map -> 
                   Map.update(map, word, 1, &(&1+1))
                 end)
  end
  def count_for(word) do 
    Agent.get(__MODULE__, fn map -> Map.get(map, word) end)
  end
  def words do 
    Agent.get(__MODULE__, fn map -> Map.keys(map) end)
  end
end

Frequency.start_link
Frequency.add_word "dave"
IO.inspect Frequency.words
Frequency.add_word "was"
Frequency.add_word "here"
Frequency.add_word "he"
Frequency.add_word "was"
IO.inspect Frequency.words
IO.puts Frequency.count_for("dave")
IO.puts Frequency.count_for("was")

