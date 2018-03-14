defmodule Chain do 
  def counter(next_pid) do 
    #IO.puts "counter has been spawned #{inspect self()}"
    receive do 
      n -> send(next_pid, n + 1)
        #IO.puts "send #{inspect next_pid} #{n+1} from #{inspect self()}"
    end
  end
  
  def create_processes(n) do 
    last = Enum.reduce 1..n, self(),
      fn (_, send_to) -> spawn(Chain, :counter, [send_to])
      end
      # start the count by sending
    #IO.puts " send last=#{inspect last}, 0 from #{inspect self()}"
    send last, 0
    # and wait for the result to come back to us
    receive do 
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end
  def run(n) do 
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

#elixir -r chain.exs -e "Chain.run"
#elixir --erl "+P 1000000" -r chain.exs  -e "Chain.run(1_000_000)"
#{12603812, "Result is 1000000"}
