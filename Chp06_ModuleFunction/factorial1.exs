defmodule Factorial do 
  def of(0), do: 1
  def of(n) do
    IO.puts "sta->n:#{to_string(n)}"
    answer = n * of(n - 1)
    IO.puts "end->n:#{to_string(n)}"
    answer
  end
end

