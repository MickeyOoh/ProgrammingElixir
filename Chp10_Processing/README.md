## Processing Collections ------ Enum and Stream

### 1. Enum  --- Processing Collections
* Convert any collection into a list
```
iex> list = Enum.to_list 1..5
[1, 2, 3, 4, 5]
```
* Concatenate collections
```
iex> Enum.concat([1,2,3], [4,5,6])
[1, 2, 3, 4, 5, 6]
iex> Enum.concat [1, 2, 3], 'abc'
[1, 2, 3, 97, 98, 99]
```
* Create collections whose elements are some function of the original:
```
iex> Enum.map(list, &(&1 * 10)
[10, 20, 30, 40. 50]
iex> Enum.map(list, &String.duplicate("*", &1))
["*", "**", "***", "****", "*****"]
```
* Select elements by position or criteria:
```
iex> Enum.at(10..20, 3)
13
iex> Enum.at(10..20, 20)
nil
iex> Enum.at(10..20, 20, :no_one_here)
:no_one_here
iex> Enum.filter(list, &(&1 > 2))
[3, 4, 5]
iex> Enum.filter(list, &Integer.is_even/1)
[2, 4]
iex> Enum.reject(list, &Integer.is_even/1)
[1, 3, 5]
```
* Sort and compare elements:
```
iex> Enum.sort ["there", "was", "a", "crooked", "man"]
["a", "crooked", "man", "there", "was"]
iex> Enum.sort ["there", "was", "a", "crooked", "man"], 
              &(String.length(&1) <= String.length(&2)
["a", "man", "was", "there", "crooked"]
iex> Enum.max ["there", "was", "a", "crooked", "man"]
"was"
iex> Enum.max_by ["there", "was", "a", "crooked", "man"], &String.length/1
"crooked"
```
* Split a collection:
```
iex> Enum.take(list, 3)
[1, 2, 3]
iex> Enum.take_every list, 2
[1, 3, 5]
iex> Enum.take_while(list, &(&1 < 4))
[1, 2, 3]
iex> Enum.split(list, 3)
{[1, 2, 3], [4, 5]}
iex> Enum.split_while(list, &(&1 < 4))
{[1, 2, 3], [4, 5]}
```
* Join a collection:
``` 
iex> Enum.join(list)
"12345"
iex> Enum.join(list, " ")
"1, 2, 3, 4, 5"
```
* Predicate collections:
```
iex> Enum.all?(list, &(&1 < 4))
false
iex> Enum.any?(list, &(&1 < 4))
true
iex> Enum.member?(list, 4)
true
iex> Enum.empty?(list)
false
```
* Merge collections:
```
iex> Enum.zip(list, [:a, :b, :c])
[{1, :a}, {2, :b}, {3, :c}]
iex> Enum.with_index(["once", "upon", "a", "time"])
[{"once", 0}, {"upon", 1}, {"a", 2}, {"time", 3}]
```
* Fold elements into a single value:
```
iex> Enum.reduce(1..100, &(&1+&2))
5050
iex> Enum.reduce(["now", "is", "the", "time"], fn word, longest ->
        if String.length(word) > String.length(longest) do 
           word
        else
           longest
        end
     end)
"time"
iex> Enum.reduce(["now", "is", "the", "time"], 0, fn word, longest ->
       if String.length(word) > longest do 
         String.length(word)
       else
         longest
       end
     end)
```
* Deal a hand of cards:
```
iex> import Enum
iex> deck = for rank <- '23456789TJQKA', suit <- 'CDHS', do: [suit, rank]
['C2', 'D2', 'H2', 'S2', 'C3', 'D3', ...]
iex> deck |> shuffle |> take(13)
iex> hands = deck |> shuffle |> chunk(13)
```

### 2. Streams --- Lazy Enumerables
#### The Enum module is greedy. This means that when you pass it a collection, it potentially consumes all the contents of that collection. It also means the result will typically be another collection. 
enum/pipeline.exs:
```
[1, 2, 3, 4, 5]
|> Enum.map(&(&1 * &1))
|> Enum.with_index
|> Enum.map(fn {value, index} -> value - index end)
|> IO.inspect        #=> [1, 3, 7, 13, 21] 

IO.puts File.read!("./words")
|> String.split
|> Enum.max_by(&String.length/1)

``` 

1. A Stream Is a Composable Enumerator
```
iex> s = Stream.map [1, 3, 5, 7], &(&1 + 1)
#Stream<[enum: [1, 3, 5, 7], funs: [#Function<37.xxxx/1 in Steam.map/2>]]>
```
 If we'd called _Enum.map_, we'd have seen the result [2,4,6,8] come back immediately.
    Treat it as a collection and pass it to a function in the _Enum_ module:
```
iex> Enum.to_list s
[2, 4, 6, 8]
```
Streams are composable

2. Infinite Streams
    Because steams are lazy, there's no need for the whole collection to be available up front. 
    This example using _Enum_ takes about 8 seconds.
```
iex> Enum.map(1..10_000_000, &(&1+1)) |> Enum.take(5)
[2, 3, 4, 5, 6]
```
 Enum is creating a 10 million element list, then taking the first five elements.
```
iex> Stream.map(1..10_000_000, &(&1+1)) |> Enum.take(5)
[2, 3, 4, 5, 6]
```
> _Stream_ result comes back instantaneously. The take call just needs five values, which it gets from the stream, Once it has them, there's no more processing.

3. Creating Your Own Stream
* Stream.cycle
  Stream.cycle takes an enumerable and returns an infinite stream containing that enumerable's elements. When it gets to the end, it repeats from the beginning, indefinitely. 
```
iex> Stream.cycle(~w{ green white }) |>
     Stream.zip(1..5) |>
   	Enum.map(fn {class, value} ->
		      ~s{<tr class="#{class}"><td>#{value}</td></tr>\n} end) |>
		IO.puts
    <tr class="green"><td>1</td></tr>
     <tr class="white"><td>1</td></tr>
     <tr class="green"><td>1</td></tr>
     <tr class="white"><td>1</td></tr>
     <tr class="green"><td>1</td></tr>
```
	 
* Stream.repeatedly
       Stream.repeatedly takes a function and invokes it each time a new value is wanted.
```
iex> Stream.repeatedly(fn -> true end) |> Enum.take(3)
[true, true, true]
iex> Stream.repeatedly(&:random.uniform/0)  |> enum.take(3)
[0.72xxxxxxx. 0.94xxxx, 0.50xxxxx]
```

* Stream.iterate
 Stream.iterate(start_value, next_fun) generates an inifinite stream.
 The first value is start_value. The next value is generated by appling next_fun to this value.

* Stream.unfold 
  Stream.unfold is related to iterate, but you can be more explicit both about the values output to the stream and about the values passed to th next iteration. You supply an initial value and a function. The function uses the argument to create two values, returned as a tuple. 
	 the first is the value to be returned by this iteration on the stream
	 the second is the value to be passed to the function on the next iteration of stream.
	 If the function returns nil, the stream terminates.

fn state -> { stream_value, new_state } end

```
iex> Stream.unfold({0, 1}, fn {f1, f2} -> {f1, {f2, f1 + f2}} end) |> Enum.take(5)
[0, 1, 2, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]
```
* Stream.resource



```
Stream.resouce(fn -> File.open("sample") end,
               fn file -> 
                 case IO.read(file, :line) do 
                    line when is_binary(line) -> { [line], file }
										_ -> {:halt, file}
								 end
							 end
							 fn file -> File.close!(file) end)
```
 
### Comrehensions
#### you often map and filter collections of things. To make your life easier(and your code easier to read), Elixir provides a general-purpose shortcut for this: 
 given one or more collections, extract all combinations of values from each, optionally filter the values, and then generate a new collection using the values that remain.
 ```
result = for generator or filter... [, into: value], do: expression
 ```

 ```
iex> for x <- [1, 2, 3, 4, 5 ], do: x * x
[1, 4, 9, 16, 25]
iex> for x <- [1, 2, 3, 4, 5 ], x < 4, do: x * x
[1, 4, 9]
iex> for x <- [1, 2], y <- [5, 6], do: x * y
[5, 6, 10, 12]
iex> for x <- [1,2], y <- [5,6], do: {x, y}
[{1, 5}, {1, 6}, {2, 5}, {2, 6}]
iex> min_maxes = [{1,4}, {2,3}, {10, 15}]
[{1,4}, {2,3}, {10, 15}]
iex> for {min,max} <- min_maxes, n <- min..max, do: n
[1, 2, 3, 4,  2, 3,  10, 11, 12, 13, 14, 15]
iex> 
iex> first8 = [1,2,3,4,5,6,7,8]
[1,2,3,4,5,6,7,8]
iex> for x <- first8, y <- first8, x >= y, rem(x * y, 10) == 0, do: {x, y}
[{5, 2}, {5, 4}, {6, 5}, {8, 5}]
 
```
 **pattern <- list**

#### Comprehensions Work on Bits, too
A bitstring (and, by extension, a binary or a string) is simply a collection of ones and zeroes. Comprehensions work its, too. 
```
iex> for << ch <- "hello" >>, do: ch
'hello'
iex> for << ch <- "hello" >>, do: <<ch>>
["h", "e", "l", "l", "o"]				#=> binary [104, 101, 108, 108, 111]
iex> for << << b1::size(3), b2::size(3), b3::size(3) >> <- "hello" >>,
...> do: "0#{b1}#{b2}#{b3}"
["0150", "0145", "0154", "0154", "0157"]
iex>
iex> name = "Dave"
"Dave"
iex> for name <- [ "cat", "dog"], do: String.upcase(name)
["CAT", "DOG"]
iex> name
"Dave"
iex>
```

#### The Value Returned by a Comprehension
```
iex> for x <- ~w{ cat dog}, into: %{}, do: { x, String.upcase(x) }
%{"cat" => "CAT", "dog" => "DOG"}
iex> for x <- ~w{ cat dog}, into: Map.new, do: {x, String.upcase(x)}
%{"cat" => "CAT", "dog" => "DOG"}
iex> for x <- ~w{ cat dog }, into: %{"ant" => "ANT"}, do: String.upcase(x)}
%{"ant" => "ANT", "cat" => "CAT", "dog" => "DOG"}
```

