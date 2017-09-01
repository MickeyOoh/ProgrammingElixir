##
# case 
## case lets you test a value againt a set of patterns, executes the code associated with the first one that maches, and returns the value of that code, The patterns may include guard clauses.
## For example, the File.open function returns a two-element tuple. If the open is successfu, it returns {:ok, file}, where file is an identifier for the open file. If the open fails, it returns {:error, reason}. We can use case to take the appropriate action when we open a file.

