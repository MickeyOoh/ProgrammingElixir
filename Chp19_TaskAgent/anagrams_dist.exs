defmodule Dictionary do 

  #@name __MODULE__
  @name {:global, __MODULE__}

  ## 
  # External API
  
  def start_link,
  do: Agent.start_link(fn -> %{} end, name: @name)

  def add_words(words),
  do: Agent.update(@name, &do_add_words(&1, words))

  def anagrams_of(word),
  do: Agent.get(@name, &Map.get(&1, signature_of(word)))

  ##
  # Internal implementation

  defp do_add_words(dict, words),
  do: Enum.reduce(words, dict, &add_one_word(&1, &2))

  defp add_one_word(word, dict),
  do: Map.update(dict, signature_of(word), [word], &[word|&1])

  defp signature_of(word),
  #do: word |> to_char_list |> Enum.sort |> to_string
  do: word |> to_charlist |> Enum.sort |> to_string

end

defmodule WordlistLoader do 
  def load_from_files(file_names) do 
    file_names
    |> Stream.map(fn name -> Task.async(fn -> load_task(name) end) end)
    |> Enum.map(&Task.await/1)
  end
  defp load_task(file_name) do 
    File.stream!(file_name, [], :line)
    #|> Enum.map(&String.strip/1)
    |> Enum.map(&String.trim/1)
    |> Dictionary.add_words
  end
end


