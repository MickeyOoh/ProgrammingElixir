Code.load_file("maps.exs", __DIR__)
Code.load_file("keywords.exs", __DIR__)

defmodule Test do 

  def run do 
    IO.puts "*** keywords test ***" 
    Canvas.draw_text("hello", fg: "red", style: "italic", style: "bold")
    IO.puts "*** maps test ***" 
    Testmaps.test1
    Testmaps.test2
  end
end

Test.run

