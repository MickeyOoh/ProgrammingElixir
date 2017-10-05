defmodule Sequence.Supervisor do
  use Supervisor
  def start_link(initial_number) do
    IO.puts "Sequence.Supervisor"
    result={:ok, sup }= Supervisor.start_link(__MODULE__, [initial_number])
    start_workers(sup, initial_number)
    result
  end
  def start_workers(sup, initial_number) do
    # Start the stash worker
    wk = worker(Sequence.Stash, [initial_number])
    {:ok, stash} =
      #Supervisor.start_child(sup, worker(Sequence.Stash, [initial_number]))
      Supervisor.start_child(sup, wk)
    IO.puts "initial_number: #{initial_number}" 
    IO.inspect wk

    # and then the subsupervisor for the actual seqeunce server
    Supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash]))
  end
  def init(_) do
    IO.puts "Sequence.Supervisor init(_)"
    supervise [], strategy: :one_for_one
  end
end
