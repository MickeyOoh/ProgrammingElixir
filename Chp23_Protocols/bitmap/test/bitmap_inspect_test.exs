defmodule Bitmap_InspetTest do
  use ExUnit.Case
  doctest Bitmap

  test "Enum.inspect fifty" do 
    fifty = %Bitmap{value: 50}
    IO.inspect Enum.reverse fifty
    IO.inspect Enum.join fifty, ":"
    IO.inspect fifty
    fifty |> Enum.into([]) |> IO.inspect
  end

"""  
defmodule Test do 

  
  Enum.into [1,1,0,0,1,0], %Bitmap{value: 0} |> IO.inspect

  big_bitmap = %Bitmap{value: 12345678901234567890}

  IO.inspect big_bitmap
  IO.inspect big_bitmap, structs: false

end  
"""
end
