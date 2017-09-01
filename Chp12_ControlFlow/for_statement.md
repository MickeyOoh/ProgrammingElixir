## **for** statement explanation

code:
```
iex> for n <- [1,2,3,4], do: n * 2
[2, 4, 6, 8]

# A comrehension with two generators
iex> for x <- [1,2], y <- [2,3], do: x * y
[2, 3, 4, 6]

# A comprehension with a generator and a filter
iex> for n <- [1,2,3,4,5,6], rem(n, 2) == 0, do: n
[2, 4, 6]
```

