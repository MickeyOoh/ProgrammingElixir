defmodule Parallel do 
  def pmap(collection, fun) do 
    me = self()
    collection
    |> Enum.map(fn (elem) ->
        spawn_link fn -> (send me, { self(), fun.(elem) }) end
       end)
    |> Enum.map(fn (pid) ->
        receive do { ^pid, result } -> result end
       end)
  end
end

filename = "./" <> Path.basename(__ENV__.file)
line_no  = __ENV__.line - 3
File.open!(filename)
|> IO.stream(:line)
|> Enum.take(line_no)
|> IO.puts

eval = """
list = Parallel.pmap 1..10, &(&1 * &1)
IO.inspect list
"""
IO.puts eval
Code.eval_string(eval)

