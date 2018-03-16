defmodule Fib do
  def of(0), do: 0
  def of(1), do: 1
  def of(n), do: Fib.of(n-1) + Fib.of(n-2)
  def start(n) do 
    IO.puts "2:start the Task.async"
    worker = Task.async(fn -> of(n) end)
    IO.puts "2:Do something else"
    IO.puts "2:Wait for the task"
    result = Task.await(worker)
    IO.puts "2:The result is #{result}"
  end
  def wait(pid) do 
    result = Task.await(pid)
  end
end

IO.puts "Start the task"
worker = Task.async(fn -> Fib.of(20) end)
IO.puts "Do something else"

IO.puts "Wait for the task"
result = Task.await(worker)

IO.puts "The result is #{result}"

IO.puts "**** "
n = 20
{time, result} = :timer.tc(Fib, :start, [n])
:io.format "Fib.of(~2B)     ~.3f(ms)~n", [n, time/1000.0]
