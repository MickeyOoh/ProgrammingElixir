defmodule Hoge do
  def say do
    receive do 
      { sender, msg } ->
      IO.puts "say:received -> #{inspect(sender)}, msg:#{msg}"
        send sender, {:ok, "Hello #{msg}" }
    end
  end
end

child_pid = spawn(Hoge, :say, [])
send child_pid, {self(), "World!"}

receive do 
  {:ok, message} ->
  IO.puts ":ok -> #{message}"
end

