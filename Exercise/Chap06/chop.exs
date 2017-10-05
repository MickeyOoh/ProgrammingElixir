defmodule Chop do 
  def guess(num, a..b) when num == (a + b)/2 do 
    IO.puts num	
	end 
  def guess(num, a..b) when num > (a + b)/2 do 
	  a = div((a + b),2)
		IO.puts "Is it #{a}"
		guess(num, a..b)
	end
	def guess(num, a..b) when num < (a + b)/2 do 
	  b = div((a + b),2)
		IO.puts "Is it #{b}"
		guess(num, a..b)
	end 
end

Chop.guess(273, 1..1000)

