defmodule Bitmap do 
  defstruct value: 0

  defimpl String.Chars, for: Bitmap do 
    def to_string(bitmap) do
      import Enum
      bitmap
      |> reverse
      |> chunk(3)
      |> map(fn three_bits -> three_bits |> reverse |> join end)
      |> reverse
      |> join("_")
    end
  end
end

defmodule Test do 

  fifty = %Bitmap{value: 50}
  IO.puts "Fifty in bits is #{fifty}"
end
