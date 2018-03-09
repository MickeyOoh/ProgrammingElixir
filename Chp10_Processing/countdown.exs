defmodule Countdown do 

  def sleep(seconds) do 
	  receive do 
		  after seconds * 1000 -> nil
		end
	end

	def say(text) do 
	  spawn fn -> :os.cmd('say #{text}') end
	end

	def timer do 
	  Stream.resource(
		  fn -> 	# the number of seconds to the start of the next minute
			  {_h,_m,s} = :erlang.time
				60 - s - 1
			end,
			fn			# wait fo the next second, then return its countdown
			  0 ->
				  {:halt, 0}

				count -> 
				  sleep(1)
					{ [inspect(count)], count - 1 }
			end,
      fn _ -> nil end  # nothing to deallocate
		)
	end
end

# iex countdown.exs
counter = Countdown.timer
printer = counter |> Stream.each(&IO.puts/1)
speaker = printer |> Stream.each(&Countdown.say/1)
speaker |> Enum.take(5)
#
