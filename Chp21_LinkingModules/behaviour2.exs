defmodule URI.HTTP do 
  @behaviour URI.Parser
  def default_prot(), do: 80
  def parse(info), do: info
end

