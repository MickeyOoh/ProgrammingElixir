defmodule BitmapTest do
  use ExUnit.Case
  doctest Bitmap

  test "Enum.count fifty" do 
    fifty = %Bitmap{value: 50}
    assert Enum.count(fifty) == 6
  end
  test "Enum.member? fifty" do 
    fifty = %Bitmap{value: 50}
    assert Enum.member?(fifty, 4) == true
    assert Enum.member?(fifty, 6) == false
  end
  test "reduce function" do 
    fifty = %Bitmap{value: 50}
    bit_list = fifty |> Enum.into([]) 
    assert bit_list == [0, 1, 1, 0, 0, 1, 0]
  end


"""  
defmodule Test do 

  IO.inspect Enum.reverse fifty
  IO.inspect Enum.join fifty, ":"
  IO.inspect fifty
  fifty |> Enum.into([]) |> IO.inspect
  
  Enum.into [1,1,0,0,1,0], %Bitmap{value: 0} |> IO.inspect

  big_bitmap = %Bitmap{value: 12345678901234567890}

  IO.inspect big_bitmap
  IO.inspect big_bitmap, structs: false

end  
"""
end
