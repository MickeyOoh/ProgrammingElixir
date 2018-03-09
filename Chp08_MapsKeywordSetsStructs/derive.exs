#import Access

defmodule Attendee do 
  #@derive Access
  defstruct name: "", over_18: false

  def run do
    a = %Attendee{name: "Sally", over_18: true}
    IO.puts inspect(a)

    IO.puts a[:name]
    IO.puts a[:over_18]
    IO.puts a.name
  end

end

#Attendee.run
