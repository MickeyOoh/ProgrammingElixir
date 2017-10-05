defmodule Sequence do
  use Application

  def start(_type, _args) do 
    IO.puts "Seqeunce start"

    children = [
      {Sequence.Supervisor, 456}
    ]

    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
