defmodule Example do 
  def func do 
    alias Mix.Tasks.Doctest, as: Doctest
    doc = Doctest.setup
    doc.run(Doctest.defaults)
  end
end

