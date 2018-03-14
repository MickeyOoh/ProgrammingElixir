Code.load_file("speaker.ex", __DIR__)

defmodule FizzBuzz do 
  import Speak

  def upto(n) when n > 0, do: _upto(1, n, [])

  defp _upto(_current, 0, result), do: Enum.reverse result
  defp _upto(current, left, result) do 
    next_answer = 
      cond do 
        rem(current, 3) == 0 and rem(current, 5) == 0 ->
          "FizzBuzz"
        rem(current, 3) == 0 -> 
          "Fizz"
        rem(current, 5) == 0 ->
          "Buzz"
        true ->
          current
      end
    say(next_answer)
    _upto(current + 1, left - 1, [ next_answer | result])
  end
end

FizzBuzz.upto(20)
|> IO.inspect
