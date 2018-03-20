defmodule My do
  defmacro macro(param) do 
    IO.inspect param
  end
end


defmodule Test do 
  require My
  @codeend (__ENV__.line - 3)
  @filename "./" <> Path.basename(__ENV__.file)

  IO.puts(IO.ANSI.clear)
  IO.puts(IO.ANSI.home)
  #text = File.read!("#{__ENV__.file}")
  #Enum.join([IO.ANSI.green, text,IO.ANSI.reset], "")
  #|> IO.puts
  IO.puts IO.ANSI.green
  File.open!(@filename)
  |> IO.stream(:line)
  |> Enum.take(@codeend)
  |> IO.puts
  IO.puts IO.ANSI.reset

  # These values represent themselves
  My.macro :atom
  My.macro 1
  My.macro 1.0
  My.macro [1,2,3]
  My.macro "binaries"
  My.macro { 1, 2 }
  My.macro do: 1

  # And these are represented by 3-element tuples
  My.macro { 1,2,3,4,5 } #=> {:"{}", [line: 20], [1,2,3,4,5]} 

  My.macro do: ( a = 1; a+a)  #=>
  #   [do:
  #     {:__block__,[],
  #       [{:=,[line: 22],[{:a,[line: 22], nil},1]},
  #        {:+,[line: 22],[{:a,[line: 22], nil},{:a,[line: 22],nil}]}]}]
  My.macro do #=> 
    1+2
  else
    3+4
  end
end

