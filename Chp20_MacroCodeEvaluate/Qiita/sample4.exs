defmodule Sample do 
  defmacro updatex() do 
    {:=, [], [{:x, [], nil}, 3]}
  end
end

defmodule Main do 
  require Sample
  import Sample

  def main() do 
    x = 0
    IO.puts "(before) x=#{x}"
    updatex()
    IO.puts "(after) x=#{x}"
  end
end

IO.inspect Main.main

