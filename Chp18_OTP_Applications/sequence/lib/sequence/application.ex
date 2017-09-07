defmodule Sequence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  #def start(_type, initial_number) do
  #  Sequence.Supervisor.start_link(initial_number)
  #end
  def start(_type, _args) do
    Sequence.Supervisor.start_link(Application.get_env(:seqeunce, :initial_number))
  end
end
