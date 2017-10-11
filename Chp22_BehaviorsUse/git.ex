defmodule Mix.SCM.Git do 
  @behaviour Mix.SCM

  def fetchable? do 
    true
  end
  def format(opts) do 
    opts[:git]
  end
end

