defmodule URI.Parser do 
  @moduledoc """
  Defines the behavior for each URI.Parser.
  Check URI.HTTP for a possible implementation.
  """
  #use Behaviour

  @doc """
  Responsible for parsing extra URL information
  """
  #defcallback parse(uri_info :: URL.Info.t) :: URI.Info.t
  @callback parse(uri_info :: URL.Info.t) :: URI.Info.t

  @doc """
  Responsible for returning the default port.
  """
  #defcallback default_port() :: integer
  @callback default_port() :: integer
end

