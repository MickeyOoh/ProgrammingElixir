defmodule Attendee do 
  defstruct name: "", paid: false, over_18: true

	def may_attend_after_party(attendee = %Attendee{}) do 
	  attendee.paid && attendee.over_18
	end

	def print_vip_badge(%Attendee{name: name}) when name != "" do 
	  IO.puts "Very cheap badge for #{name}"
	end
	def print_vip_badge(%Attendee{}) do 
	  raise "missing name for badge"
  end

  ## Verify the code
  def run do
    IO.puts "=== check %Attendee{} ==="
    IO.puts "  #{inspect(%Attendee{})}"
    a1 = %Attendee{name: "Dave", over_18: true}
    IO.puts "  a1 = %Attendee{name: \"Dave\", over_18: true}\n    => #{inspect(a1)}"
    rt1=Attendee.may_attend_after_party(a1)
    IO.puts "Attendee.may_attend_after_party(a1) =>#{rt1}"
    a2 = %Attendee{a1 | paid: true}
    IO.puts "  a2 = %Attendee{a1 | paid: true}\n    => #{inspect(a2)}"
    rt2 = Attendee.may_attend_after_party(a2)
    IO.puts "Attendee.may_attend_after_party(a2) =>#{rt2}"
    Attendee.print_vip_badge(a2)
    a3 = %Attendee{}
    IO.puts "  #{inspect(a3)}"
    Attendee.print_vip_badge(a3)

  end
end

Attendee.run
