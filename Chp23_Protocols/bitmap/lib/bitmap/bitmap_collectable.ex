defimpl Collectable, for: Bitmap do 
  use Bitwise

  def into(%Bitmap{value: target}) do 
    {target, fn
      acc, {:cont, next_bit} -> (acc <<< 1) ||| next_bit
      acc, :done             -> %Bitmap{value: acc}
      _, :halt               -> :ok
     end}
  end
end

