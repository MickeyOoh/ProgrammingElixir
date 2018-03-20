defmodule My do
  defmacro mydef(name) do 
    quote bind_quoted: [name: name] do  
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
Two things happen here.
First, the binding makes the current value of name avaliable inside the body of the quoted block.
Second, the presence of the *bind_quoted:* option automatically defers the execution of the unquote calls in the body.
the methods are defined at runtime.
As its name implies, bind_quoted takes a quoted code fragment.
"""
IO.puts @comment

