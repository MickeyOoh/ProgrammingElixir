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


# Enum.map and Stream.map comparison
range = 1..5
test = Enum.map range, &(&1 * 2)
IO.inspect test

range = 1..3
stream = Stream.map(range, &(&1 * 2))
IO.inspect stream
test = Enum.map(stream, &(&1 + 1))
IO.inspect test

