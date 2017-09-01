defmodule URI.HTTP do 
  @behaviour URI.Parser
  def default_port(), do: 80
  def parse(info), do: info
end

