defmodule Sample do 
  defmacro sample_macro(param) do 
    IO.puts "### sample_macro ###"
    IO.inspect param
    param
  end
  def sample_func(param) do 
    IO.puts "### sample_func ###"
    IO.inspect param
    param
  end
end

defmodule Main do 
  require Sample
  import Sample

  def main() do 
    x = 1
    IO.puts "result = #{sample_macro(x > 0)}"
    IO.puts "result = #{sample_func(x > 0)}"
  end
end

Main.main

