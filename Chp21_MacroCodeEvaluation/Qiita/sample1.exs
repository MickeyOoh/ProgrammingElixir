defmodule Sample do 
  defmacro sample_macro(param) do 
    IO.puts "### sample_macro ###"
    IO.inspect param
    ""
  end
  def sample_func(param) do 
    IO.puts "### sample_func ###"
    IO.inspect param
    ""
  end
end

defmodule Main do 
  require Sample
  import Sample

  def main() do 
    x = 1
    sample_macro(x > 0)
    sample_func(x > 0)
  end
end

Main.main

