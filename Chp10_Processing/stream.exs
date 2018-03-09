ExUnit.start()

defmodule TestStream do 
  use ExUnit.Case
  import Code
  setup_all do 
    IO.puts __ENV__.file
    IO.puts __ENV__.line
  end
  def print_result(eval) do 
    IO.puts eval
    {result, _}  = eval_string(eval)
    IO.puts "result => #{inspect result}"
  end

  test "stream1.exs p100" do 
    eval = """
    ## ** stream1.exs **
    [1,2,3,4]
    |> Stream.map(&(&1 * &1))
    |> Stream.map(&(&1 + 1))
    |> Stream.filter(fn x -> rem(x,2) == 1 end)
    |> Enum.to_list
    """
    print_result(eval)
  end

  test "stream2.exs p101" do
    eval = """
    ## stream2.exs p101
    IO.puts File.open!("./words")
    |> IO.stream(:line)
    |> Enum.max_by(&String.length/1)
    """
    print_result(eval)
  end

  test "stream3.exs p101" do 
    eval = """
    ## stream3.exs p101
    IO.puts File.stream!("./words")
    |> Enum.max_by(&String.length/1)
    """
    print_result(eval)
  end
  test "Enum.map and Stream.map comparison" do 
    eval= """
    ## ** Enum.map and Stream.map comparison **
    # Enum case
    range = 1..5
    Enum.map range, &(&1 * 2)
    """
    print_result(eval)

    eval = """    
    # Stream case
    range = 1..3
    Stream.map(range, &(&1 * 2))
    |> Enum.map(&(&1 + 1))
    """
    print_result(eval)
  end
  test "Stream.cycle test" do 
    Stream.cycle(~w{ green white }) 
    |> Stream.zip(1..5) 
    |> Enum.map(fn {class, value} ->
         ~s{<tr class="#{class}"><td>#{value}</td></tr>\ñ} end) 
    |> IO.puts
  end

  test "Stream.repeatedly" do 
    IO.puts "** Stream.repeatedly test **"
    Stream.repeatedly(fn -> true end) |> Enum.take(3)
    |> IO.inspect

    Stream.repeatedly(&:random.uniform/0) |> Enum.take(3)
    |> IO.inspect
  end
  test "Stream.iterate" do 
    IO.puts "** Stream.iterate test **"
    Stream.iterate(0, &(&1+1)) |> Enum.take(5)
    |> IO.inspect
    Stream.iterate(2, &(&1*&1)) |> Enum.take(5)
    |> IO.inspect

    Stream.iterate([], &[&1]) |> Enum.take(5)
    |> IO.inspect
  end
  test "Stream.unfold" do 
    IO.puts "** Stream.unfold test **"
    # fn state -> { stream_value, new_state } end
    Stream.unfold({0,1}, fn {f1, f2} -> {f1, {f2, f1+f2}} end) 
    |> Enum.take(15)
    |> IO.inspect
  end
end


