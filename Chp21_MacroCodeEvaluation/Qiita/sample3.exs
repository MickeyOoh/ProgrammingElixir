defmodule Sample do 
  defmacro sample(args) do 
    IO.inspect args
    ""
  end
end
defmodule Main do 
  require Sample
  import Sample

  def main() do 
    sample(this is a pen)
    sample(this is a <b>new</b> pen)
  end
end

IO.inspect Main.main

