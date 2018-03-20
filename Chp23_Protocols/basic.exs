defmodule Blob do 
  defstruct content: nil
end

defmodule Test do 
  b = %Blob{content: 123}
  #IO.inspect b
  IO.puts "IO.inspect b => #{inspect b}"
  IO.puts "IO.inspect b, structs: false =>"
  IO.inspect b, structs: false
end
