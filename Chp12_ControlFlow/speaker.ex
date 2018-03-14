defmodule Speak do 
  def say(text) do 
    spawn fn -> :os.cmd('say #{text}') end
    sleep(1)
  end

  def sleep(seconds) do 
    receive do 
    after seconds*1000 -> nil
    end
  end
end
