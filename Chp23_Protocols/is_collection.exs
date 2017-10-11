defprotocol Collection do 
  @fallback_to_any true
  def is_collection?(value)
end
defimpl Collection, for: [List, Tuple, BitString, Map] do 
  def is_collection?(_), do: true
end
defimpl Collection, for: Any do 
  def is_collection?(_), do: false
end

defmodule Display do 
  def show(file_name) do 
    text = File.read!(file_name)
    Enum.join([IO.ANSI.green, text, IO.ANSI.reset], "")
    |> IO.puts
  end
end

defmodule Test do 
  Display.show(__ENV__.file)
  Enum.each [ 1, 1.0, [1, 2], {1,2}, %{}, "cat"], fn value ->
    IO.puts "#{inspect value}: #{Collection.is_collection?(value)}"
  end
end

