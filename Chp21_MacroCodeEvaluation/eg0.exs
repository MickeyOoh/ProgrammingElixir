defmodule My do 
  defmacro macro(code) do 
    IO.inspect code
    # The code we give it when we invoke the macro is passed
    # as an internal representation, and when the macro returns
    # that code, that representation is injected back into the
    # compile tree.
    code
  end
end

defmodule Test do 
  require My
  My.macro(IO.puts("hello"))
end

