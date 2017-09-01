#IO.puts File.read!("/Users/Mikio/test/Elixir/words")
IO.puts File.read!("./words")
    |> String.split
		|> Enum.max_by(&String.length/1)

