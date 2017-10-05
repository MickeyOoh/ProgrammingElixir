defmodule Mod do 
  def func1 do 
    IO.puts("in func1")
  end
  def func2 do 
    func1()
    IO.puts("in func2")
  end
end
Mod.func1    #=> in func1
Mod.func2    #=> in func1   \n in func2

