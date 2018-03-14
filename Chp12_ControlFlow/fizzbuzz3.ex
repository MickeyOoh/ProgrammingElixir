Code.load_file("speaker.ex",__DIR__)

defmodule FizzBuzz do 
  import Speak
  
  def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

  defp fizzbuzz(n), do: _fizzbuzz(n, rem(n, 3), rem(n, 5))

  defp _fizzbuzz(_n, 0, 0), do: "FizzBuzz" |> say
  defp _fizzbuzz(_n, 0, _), do: "Fizz" |> say
  defp _fizzbuzz(_n, _, 0), do: "Buzz" |> say
  defp _fizzbuzz( n, _, _), do: n |> say

  # def upto(n) when n > 0 do 
  #   1..n |> Enum.map(&fizzbuzz/1)
  # end
  # defp fizzbuzz(n)  when rem(n, 3) == 0 and rem(n, 5) == 0,
  #   do: "FizzBuzz" |> say
  # defp fizzbuzz(n)  when rem(n, 3) == 0, 
  #   do: "Fizz" |> say
  # defp fizzbuzz(n)  when rem(n, 5) == 0, 
  #   do: "Buzz" |> say
  # defp fizzbuzz(n), do: n |> say

end

FizzBuzz.upto(20)
|> IO.inspect


