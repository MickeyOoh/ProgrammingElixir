####
## Guard-Clause Limitations
### comaparison operators
> ==. !=, ===, !==, >, <, <=, >=
### Boolean and negation operators
> or, and, not, !.   Note: || and && are not allowed
### Arithmetic operators
> <> and ++, as long as the left side is a literal
### The in operator
> Membershop in a collection or range
### Type-check functions
>

### Other functions
> * abs(number)
> * bit_size(bitstring)
> * byte_size(bitstring)
> * div(number, number)
> * elem(type, n)
> * float(term)
> * hd(list)
> * length(list)
> * node(), node(pid|ref|port)
> * rem(number, number)
> * round(number)
> * self()
> * tl(list)
> * trunc(number)
> * tuple_size(tuple)


## Default Parameters
### When you define a named function, you can give a default value to any of its parameters by using the syntax **parm \\ value**.

code: 
```
defmodule Exmaple do 
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do 
	  IO.inspect [p1, p2, p3, p4]
	end
end

Example.func("a","b")			 			# => ["a", 2, 3, "b"]
Example.func("a","b","c")    		# => ["a","b", 3, "c"]
Example.func("a","b","c","d")  	# => ["a","b","c","d"]
```

## The Amazing **Pipe** Operator
code: 
```
people = DB.find_customers
orders = Orders.for_customer(people)
tax    = sales_tax(orders, 2013)
filing = prepare_filing(tax)
```
Bread-and-Butter programming. 
```
filing=prepare_filing(sales_tax(Orders.for_customers(DB.find_customers), 2013))
```
Then now 
```
filing = DB.find_customers
				   |> Orders.for_customers
					 |> sales_tax(2013)
					 |> prepare_filing
```

## The import Directive

> import Module [, only:|except: ]
 
