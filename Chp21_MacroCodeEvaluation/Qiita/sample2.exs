defmodule Sample do 
  defmacro sample() do 
    {:hello, [], nil}
  end
end

defmodule Main do 
  require Sample
  import Sample

  def hello() do 
    IO.inspect "hello"
  end
  def main() do 
    sample()
  end
end
Main.main

