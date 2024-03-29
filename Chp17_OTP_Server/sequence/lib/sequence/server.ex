defmodule Sequence.Server do 
  use GenServer

  def start_link(current_number) do 
    IO.puts "start_link is called #{current_number}." 
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end
  def next_number do 
    GenServer.call __MODULE__, :next_number
  end
  def increment_number(delta) do 
    GenServer.cast __MODULE__, {:increment_number, delta}
  end
  def init(current_number) do
    IO.puts "init pid=#{inspect self()}"
    {:ok, current_number}
  end

  #####
  # GenSerer implementation

  def handle_call(:next_number, _from, current_number) do
    IO.puts "call #{inspect current_number}"
    { :reply, current_number, current_number + 1}
  end
  ## add cast
  def handle_cast({:increment_number, delta}, current_number) do 
    IO.puts "cast #{inspect delta}"
    { :noreply, current_number + delta}
  end
  def format_status(_reason, [ _pdict, state ]) do 
    [data: 
     [{'State',"My current state is '#{inspect state}', and I'm happy"}]
    ]
  end
end

