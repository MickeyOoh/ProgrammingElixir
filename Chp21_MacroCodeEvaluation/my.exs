defmodule My do 
  def myif(condition, clauses) do
    IO.puts "condition -> #{inspect condition}"
    IO.puts "clauses -> #{inspect clauses}"
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    
    case condition do 
      val when val in [false, nil]
          -> else_clause
      _otherwise
          -> do_clause
    end
  end
end

defmodule Test do 
  require My
  @doc """
  When we call the **myif** function, Elixir has to evaluate all of its
  paramters before passing them in. So both the **do:** and **else:** 
  clauses are evaluated, and we see their output.  
  ```
  1 == 2
  1 != 2
  ```
  Because **IO.puts** returns **:ok** on success, what actually gets passed
  to **myif** is `myif 1==2, do: :ok, else: :ok`
  This is why the final return value is :ok.

  """
  My.myif 1==2, do: (IO.puts "1 == 2"), else: (IO.puts "1 != 2")

end
