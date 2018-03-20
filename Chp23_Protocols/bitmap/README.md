# Bitmap
----

`$ iex -S mix`

1. bitmap_enumerable.exs test
```
iex> fifty = %Bitmap{value: 50}
%Bitmap{50=110010}
iex> IO.puts Enum.count fifty
6 

iex> Enum.member? fifty, 4
true
iex> Enum.member? fifty, 6
false

iex> fifty |> Enum.into([])
[0, 1, 1, 0, 0, 1, 0]
```
Before implement Collectable function `bitmap_collectable.ex`
If we try putting the values from a list into a bitmap, we get an error:
```
iex> Enum.into [0,1,1,0,0,1,0], %Bitmap{value: 0}
** (Protocol.UndefinedError) protocol Collectable not implemented for %Bitmap{value: 0}
```

Then implemented `bitmap_collectable.exs`
```
iex(9)> Enum.into [0,1,1,0,0,1,0], %Bitmap{value: 0}
%Bitmap{50=110010}
```
It works like this:
* Enum.into calls the into function for Bitmap, passing it the target value (%Bitmap{value: 0}) in this case
* Bitmap.into returns a tuple. The first element is the value, extracted from the bitmap structure. This acts as the initial value for an accumulator. The second element of the tuple is a function.
* Enum.into then calls this function, passing it the accumulator and a command. If the command is :done, the iteration over collection being injected into the bitmap has finished, so we return a new bitmap using the accumulator as a value. If the command is :halt, the iteration has terminated early, and nothing needs to be done.
* The real work is done when the function is passed the {:cont, next_val} command.
