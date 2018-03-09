defmodule Parse do

  def number([ ?- | tail ]), do: _number_digits(tail, 0) * -1
  def number([ ?+ | tail ]), do: _number_digits(tail, 0) 
  def number(str),           do: _number_digits(str,  0)

  defp _number_digits([], value),  do: value
  defp _number_digits([ digit | tail ], value)
  when digit in '0123456789' do
    _number_digits(tail, value * 10 + digit - ?0)
  end
  defp _number_digits([ non_digit | _ ], _) do 
    raise "Invalid digit '#{[non_digit]}'"
  end
end

filename = "./" <> Path.basename(__ENV__.file)
line_no  = __ENV__.line - 3
File.open!(filename)
|> IO.stream(:line)
|> Enum.take(line_no)
|> IO.puts

IO.puts "** execute program **"
IO.puts "Parse.number('123')  => #{Parse.number('123')} "
IO.puts "Parse.number('-123') => #{Parse.number('-123')}"
IO.puts "Parse.number('+123') => #{Parse.number('+123')}"
IO.puts "Parse.number('+9')   => #{Parse.number('+9')}"

