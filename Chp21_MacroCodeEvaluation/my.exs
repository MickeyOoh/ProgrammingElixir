defmodule My do 
  def myif(condition, clauses) do
    IO.inspect condition
    IO.inspect clauses
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

  My.myif 1==2, do: (IO.puts "1 == 2"), else: (IO.puts "1 != 2")

end
