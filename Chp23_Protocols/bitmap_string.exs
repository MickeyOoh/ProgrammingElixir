defmodule Bitmap do 
  defstruct value: 0

  defimpl String.Chars do 
    def to_string(value), do: Enum.join(value, "")
  end
  def run do 
    fifty = %Bitmap{value: 50}
    IO.puts "Fifty in bits is #{fifty}"
  end

end

#fifty = %Bitmap{value: 50}
#IO.puts "Fifty in bits is #{fifty}"
Bitmap.run
