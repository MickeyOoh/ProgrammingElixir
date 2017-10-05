defmodule Sequence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  #def start(_type, initial_number) do
  #  Sequence.Supervisor.start_link(initial_number)
  #end
  def start(_type, _args) do
    IO.puts "start"
    init_value = Application.get_all_env(:seqeunce)
    IO.inspect init_value 
      
    children = [
      {Sequence.Supervisor, 456}
    ]
    opts = [strategy: :one_for_one, name: Sequence.Supervisor, debug: [:trace]] 
    Supervisor.start_link(children, opts)
    #Supervisor.start_link(Sequence.Supervisor, init_value, opts)
    #Sequence.Supervisor.start_link(Application.get_env(:seqeunce, :initial_number))
  end
end
