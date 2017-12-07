defmodule Sum do 
  def sum(0, _), do: 0
  def sum(n, cnt) do
    cnt = cnt + 1 
    IO.puts to_string(cnt)
    sum(n - 1, cnt) + n
  end
end
