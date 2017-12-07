defmodule My do 
  defmacro macro(code) do 
    IO.puts "code: #{inspect code}"
    # Even though we passed `IO.puts("hello")` as a parameter,
    # it was never executed by Elixir. Instead, it ran the 
    # code fragment we returned using quote.
    quote do: IO.puts "Different code"
  end
end

defmodule Test do 
  require My
  My.macro(IO.puts("hello"))
end


