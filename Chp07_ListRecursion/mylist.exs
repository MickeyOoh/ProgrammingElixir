defmodule MyList do 
  def len([]),			do: 0
	def len([_head | tail]), do: 1 + len(tail)

  def square([]),        do: []
  def square([ head | tail ]), do: [ head * head | square(tail)]

  def add_1([]),						 do: []
	def add_1([head | tail]),  do: [ head + 1 | add_1(tail) ]

  def map([], _func),				do: []
	def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  #def sum([], total), 			do: total
  #def sum([ head | tail ], total), do: sum(tail, head + total)
  def sum(list),      do: _sum(list, 0)

  defp _sum([], total), 			do: total
	defp _sum([ head | tail ], total), do: _sum(tail, head+total)
  
  def reduce([], value, _) do 
    value
  end
  def reduce([head | tail], value, func) do 
    reduce(tail, func.(head, value), func)
  end

end

#IO.puts File.read! ("mylist.exs")

IO.puts "2. square func test"
IO.puts "  MyList.square []  => #{inspect(MyList.square [])}"
b = MyList.square [4,5,6]
IO.puts "  MyList.square [4,5,6]  => #{inspect(b)}"

IO.puts "  MyList.add_1 [1000]  => #{inspect(MyList.add_1 [1000])}"
IO.puts "  MyList.add_1 [4,6,8]  => #{inspect(MyList.add_1 [4,6,8])}"

a = MyList.map [1,2,3,4], fn (n) -> n * n end
IO.puts "  MyList.map [1,2,3,4], fn (n) -> n * n end => #{inspect(a)}"
b = MyList.map [1,2,3,4], fn (n) -> n + 1 end
IO.puts "  MyList.map [1,2,3,4], fn (n) -> n + 1 end => #{inspect(b)}"

c = MyList.map [1,2,3,4], fn (n) -> n > 2 end
IO.puts "  MyList.map [1,2,3,4], fn (n) -> n > 2 end => #{inspect(c)}"
#d = MyList.sum([1,2,3,4,5], 0)
#IO.puts "  MyList.sum([1,2,3,4,5],0) => #{inspect(d)}"
#e = MyList.sum([11,12,13,14,15], 0)
#IO.puts "  MyList.sum([11,12,13,14,15], 0) => #{inspect(e)}"
d = MyList.sum([1,2,3,4,5])
IO.puts "  MyList.sum([1,2,3,4,5]) => #{inspect(d)}"
e = MyList.sum([11,12,13,14,15])
IO.puts "  MyList.sum([11,12,13,14,15]) => #{inspect(e)}"

a = MyList.reduce([1,2,3,4,5], 0, &(&1 + &2))
IO.puts "  MyList.reduce([1,2,3,4,5], 0, &(&1+&2)) => #{inspect(a)}"
b = MyList.reduce([1,2,3,4,5], 1, &(&1 * &2))
IO.puts "  MyList.reduce([1,2,3,4,5], 1, &(&1*&2)) => #{inspect(b)}"
