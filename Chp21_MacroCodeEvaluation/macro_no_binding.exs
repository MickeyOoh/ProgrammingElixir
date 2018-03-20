defmodule My do
  defmacro mydef(name) do 
    quote do 
      def unquote(name)(), do: unquote(name)
    end
  end
end

defmodule Test do 
  require My
  [ :fred, :bert ] |> Enum.each(&My.mydef(&1))
end

IO.puts Test.fred

@comment """
At the time the macro is called, the *each* loop hasn't yet executed, so we have no valid name to pass it.
This is where bindings come in: ==> macro_binding.exs
"""

IO.puts @comment
