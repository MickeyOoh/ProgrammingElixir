defmodule MyList do
  @max_value 0
	def max([], value), do: 0

  def max([ head | tail], true) do 
	   max( tail, @max_value >= head)
	end
  def max([head | tail], false) do 
	   max( tail, @max_value >= head)
	   @max_value = head
	end
end	  
