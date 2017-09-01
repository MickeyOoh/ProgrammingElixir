IO.puts File.open!("./stream.exs")
    |> IO.stream(:line)
    |> Enum.map

