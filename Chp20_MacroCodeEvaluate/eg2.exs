defmodule My do 
  defmacro macro(code) do 
    quote do 
      #IO.inspect(code)
      IO.inspect(unquote(code))
    end
    #IO.inspect code
    #quote do: IO.puts "Different code"
  end
end

defmodule Test do 
  require My
  My.macro(IO.puts("hello"))
end


