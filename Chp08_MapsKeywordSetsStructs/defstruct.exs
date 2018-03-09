defmodule Subscriber do 
  defstruct name: "", paid: false, over_18: true

  def run do
    IO.puts "defstruct name: \"\", paid: false, over_18: true"
    IO.puts "iex> s1 = %Subscriber{}"
    s1 = %Subscriber{}
    IO.inspect s1
    IO.puts "iex> s1 = %Subscriber{name: \"Dave\"}"
    s2 = %Subscriber{name: "Dave"}
    IO.inspect s2
    IO.puts "iex> s1 = %Subscriber{name: \"Mary\", paid: true}"
    s3 = %Subscriber{ name: "Mary", paid: true}
    IO.inspect s3
    IO.puts "iex> s3.name\n#{s3.name}"

    IO.puts "iex> %Subscriber{name: a_name} = s3"
    %Subscriber{name: a_name} = s3
    IO.inspect s3
    IO.puts "iex> a_name\n#{a_name}"

    IO.puts "iex> s4 = %Subscriber{ s3 | name: \"Marie\"}"
    s4 = %Subscriber{ s3 | name: "Marie"}
    IO.inspect(s4)
  end 
end

Subscriber.run()
