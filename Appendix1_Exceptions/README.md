Exceptions: raise and try, catch, and throw
-----

Raising an Exception
-----

```
iex(1)> raise "Giving up"
** (RuntimeError) Giving up

iex(1)> raise RuntimeError
** (RuntimeError) runtime error

iex(1)> raise RuntimeError, message: "override message"
** (RuntimeError) override message
```

You can interrupt exceptions using the *try* function. It takes a block of code to execute, and optional *rescue*, *catch*, and *after* clauses.


