defmodule Chop do 
  def guess(actual, range) do
    a..b = range
    _guess(actual, a..div(a+b, 2), div(a+b,2))
  end

  defp _guess(actual, _, expected) when actual == expected do 
    IO.puts actual
    actual  
	end 
  defp _guess(actual, a.._b, expected) when actual < expected do 
		IO.puts "Is it #{expected}"
		_guess(actual,a..expected, div(a+expected,2))
	end
	defp _guess(actual, _a..b, expected) when actual > expected do 
		IO.puts "Is it #{expected}"
		_guess(actual, expected..b, div(expected+b,2))
	end 
end

Chop.guess(273, 1..1000)
Chop.guess(273, 1..993)
Chop.guess(273, 1000)

