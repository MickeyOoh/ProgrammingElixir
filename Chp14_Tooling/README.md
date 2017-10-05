Tooling
----

Testing
----
When I document my functions, I like to include examples of the function being used— comments saying things such as, "Feed it these arguments, and you'll get this result."
In the Elixir world, a common way to do this is to show the function being used in an iex session.

[table_formatter.ex](issues/lib/issues/table_formatter.exs)

Now how some of the documentation contains sample iex sessions. I like doing this.
It helps people who come along later understand how to use my code.
But, as importantly, it lets me understand what my code will feel like to use.
I typically write these sample sessions before I start on the code, changing stuff around until the API feels right.
But the problem with comments is that they just don't get maintained. the code changes, the comment gets stale, and it becomes useless. 
Fortunately, ExUint has *doctest*, a tool that extracts the iex sessions from your code's @doc strings, runs it, and checks that the output agrees with the comment.
To invoke it, simply add one or more
```
doctest <<ModuleName>>
```

```doc_test.exs
defmodule DocTest do 
  use ExUnit.Case
	doctest Issues.TableFormatter
end

$ mix test test/doc_test.exs
```

#### Structuring Test
You'll often find yourself wanting to group your tests at a finer level than per module. For example, you might have multiple tests for a particular function, or multiple functions that work on the same test data.
ExUnit has you covered.

[pbt/test/describe.exs](pbt/test/describe.exs)

The *setup* function is invoked automatically before each test is run.
(There's also *setup_all* that is just invoked once for the test run.)
The *setup* function returns a keyword list of named test data. In testing circles, this data, which is used to drive tests, is called a *fixture*.

