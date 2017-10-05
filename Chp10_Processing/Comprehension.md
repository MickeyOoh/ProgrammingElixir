Comprehensions  *<-*
----
it is common to loop over an Enumerable, often filtering out some results and mapping values into another list.
Comprehensions are syntactic sugar for such constructs: they group those common tasks into the **for** special form.

For example, we can map a list of integers into their squared values:

```
iex> for n <- [1,2,3,4], do: n * n
[1, 4, 9, 16]

iex> for n <- 1..4, do: n * n
[1, 4, 9, 16]

iex> values = [good: 1, good: 2, bad: 3, good: 4]
[good: 1, good: 2, bad: 3, good: 4]
iex> for {:good, n} <- values, do: n * n
[1, 4, 16]

iex> dirs = ['Chp06_ModuleFunction', 'Chp07_ListRecursion']
iex> for dir <- dirs,
...>     file <- File.ls!(dir),
...>     path = Path.join(dir, file)
...>     File.regular?(path) do
...>    File.stat!(path).size
...> end
[143, 143, 145, 185, 149, 307, 78, 94, 309, 211, 193, 6205, 116, 2060, 2484,
 248, 75, 182, 179, 390, 699, 416, 284]
```

Comprehensions generaly provide a much more concise represeantation than using the equivalent functions from teh *Enum* and *Stream* modules.
Furthermore, comprehensions also allow multiple generators and filters to be given. 

Multiple generators can also be used to calculate the artesian product of two lists:
```
iex> for i <- [:a, :b, :c], j <- [1,2], do: {i, j}
[a: 1, a: 2, b: 1, b: 2, c: 1, c: 2]

defmodule Triple do 
  def pythagorean(n) when n > 0 do
	  for a <- 1..n,
			  b <- 1..n,
				c <- 1..n,
				a + b + c <= n,
				a*a + b*b == c*c,
				do: {a, b, c}
	end
end
```

Bitstring generators
----
Bitstring generators are also supported and are very useful when you need to comprehend over bitstring streams. The example below receives a list of pixels from a binary with their respective red, green, and blue values and converts them into tuples of three elements each:
```
iex> pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
iex> for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b}
```

The *:into* option
-----

```
iex> for << c <- "hello world" >>, c != ?\s, into: "", do: <<c>>
"helloworld"
iex> for {key, val} <- %{"a" => 1, "b" => 2}, into: %{}, do: {key, val * val}
%{"a" => 1, "b" => 4}

iex> stream = IO.stream(:stdio, :line)
iex> for line <- stream, into: stream do 
...>   String.upcase(line) <> "\n"
...> end
hello world!
HELLO WORLD!
``` 


