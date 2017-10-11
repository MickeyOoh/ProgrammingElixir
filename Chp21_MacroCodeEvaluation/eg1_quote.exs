defmodule My do 
  defmacro macro(code) do 
    quote do 
      IO.inspect code
    end
  end
end

defmodule Test do 
  require My
  My.macro(IO.puts("hello"))
end

