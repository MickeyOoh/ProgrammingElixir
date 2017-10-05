defmodule Chop do 
  def guess(num, low..high) do
    _guess(num, low, high)
  end

  def _guess(num, low, high) when num == (low + high)/2 do 
    IO.puts num	
	end 
  def _guess(num, low, high) when num > (low + high)/2 do 
	  low = div((low + high),2)
		IO.puts "Is it #{low}"
		_guess(num,low, high)
	end
	def _guess(num, low, high) when num < (low + high)/2 do 
	  high = div((low + high),2)
		IO.puts "Is it #{high}"
		_guess(num, low, high)
	end 
end

Chop.guess(273, 1..1000)

