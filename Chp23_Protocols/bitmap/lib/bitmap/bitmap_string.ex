defimpl String.Chars, for: Bitmap do 
  def to_string(bitmap) do
    import Enum
    bitmap
    |> reverse
    |> chunk(3)
    |> map(fn three_bits -> three_bits |> reverse |> join end)
    |> reverse
    |> join("_")
  end
end
