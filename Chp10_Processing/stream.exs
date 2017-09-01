##
# stream1.exs
[1,2,3,4]
|> Stream.map(&(&1 * &1))
|> Stream.map(&(&1 + 1))
|> Stream.filter(fn x -> rem(x,2) == 1 end)
|> Enum.to_list
|> IO.inspect
##
# stream2.exs
IO.puts File.open!("./words")
|> IO.stream(:line)
|> Enum.max_by(&String.length/1)
##
# stream3.exs
IO.puts File.stream!("./words")
|> Enum.max_by(&String.length/1)
