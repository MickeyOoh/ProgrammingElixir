## Strings and Binaries
### String Literal
* Strings can hold cahracters in UTF-8 encoding.
* They may contain escape sequences:
  \a BEL (0x07)  \b  BS(0x08)   \d DEL(0x7f)
	\e ESC(0x1b)   \f  FF(0x0c)   \n NL(0x0a)
	\r CR(0x0d)    \s  SP(0x20)   \t TAB(0x09)
	\v VR(0x0b)    \xhhh 1-6 hex digits

* they allow interpoltaion on Elixir expressions using the syntax #{..}.
```
iex> name = "dave"
iex> "Hello, #{String.capitalize name}!"
"Hello, Dave!"
```
* Characters that would otherwise have special meaning can be escaped with a backslash.
* They support heredocs.

1. Heredocs
  Any string can span seveal lines. IO.puts/IO.write
	We want to see the contents without this.
```
IO.write "
  my
	string
"
```
2. Sigils

### Single-Quoted Strings -- Lists of Character Codes
```
iex> str = 'wombat'
iex> is_list str
true
iex> length str
6
iex> Enum.reserve str
'tabmow'
```

#### This is confusing: iex says it is a list, but it shows the value as a string. That's because iex prints a list of integers as a string if it believes each nuber in the list is a printable character.
```
iex> [ 67, 65, 84 ]
'CAT'
iex> str = 'wombat'
iex> :io.format "~w~n", [ str ]
[119, 111, 109, 98, 97, 116]
iex> List.to_tuple str
{119, 111, 109, 98, 97, 116}
iex> str ++ [0]
[119, 111, 109, 98, 97, 116, 0]
## List representation
iex> 'pole' ++ 'vault'
'polevault'
iex> 'pole' -- 'vault'
'poe'
iex> List.zip [ 'abc', '123' ]
[ {97, 49}, {98, 50}, {99, 51}]
iex> [head | tail ] = 'cat'
'cat'
iex> head
99
iex> tail
'at'
iex> [head | tail]
'cat'
```

## Binaries
  The binary type represents a sequence of bits.
	A binary literal looks like << term,...>>
```
iex> b = << 1, 2, 3 >>
<<1, 2, 3>>
iex> byte_size b
3
iex> bit_size b
24
iex> b = << 1::size(2), 1::size(3) >>
<< 9:: size(5)>>
iex> byte_size b
1
iex> bit_size b
5
iex> int = << 1 >>
<<1>>
iex> float = << 2.5 :: float >>
<<64, 4, 0, 0, 0, 0, 0, 0>>
iex> mix = << int :: binary, float >>

```

### Strings and Elixir Libraries
'at(str, offset)'
    Returns the grapheme at the given offset (starting at 0). Nggative
		offsets count from the end of the string.
```
iex> String.at("dog", 0)
"d"
iex> String.at("dog", -1)
"g"
iex> String.capitalize "ecole"
"Ecole"
iex> String.capitalize "IIIII"
"Iiiii"
iex> String.codepoints("Jose's dog")
["J", "o", "s", "e", "'", "s", " ", "d", "o ", "g"]
iex> String.downcase "0RSteD"
"0rsted"
iex> String.duplicate "Ho! ", 3
"Ho! Ho! Ho! "
iex> String.ends_with? "string", ["elix", "stri", "ring"]
true
iex> String.first "dog"
"d"
iex> String.last "dog"
"g"
iex> String.length "abcde"
5
iex> String.ljust("cat", 5)
"cat  "
iex> String.lstrip "\t\f   Hello\t\n"
"Hello\t\n"
iex> String.lstrip "!!!SALE!!!", ?!
"SALE!!!"
##
# nextcodepoint.ex
#
iex> String.printable? "Jose"
true
iex> String.printable? "\x{0000} a null"
false
iex> String.replace "the cat on the mat", "at", "AT"
"the cAT on the mAT"
iex> String.replace "the cat on the mat", "at", "AT", global: false
"the cAT on the mat"
iex> String.replace "the cat on the mat", "at", "AT", insert_replaced: 0
"the catAT on the matAT"
iex> String.replace "the cat on the mat", "at", "AT", insert_replaced: [0,2]
"the catATat on the matATat"
iex> String.reverse "pupils"
"slipup"
iex> String.rjust("cat", 5, ?>)
">>cat"
iex> String.rstrip(" line \r\n")
" line"
iex> String.rstrip "!!!SALE!!!", ?!
"!!!SALE"
iex> String.slice "the cat on the mat", 4, 3
"cat"
iex> String.slice "the cat on the mat", -3, 3
"mat"
iex> String.split "   the cat on the mat   "
["the", "cat", "on", "the", "mat"]
iex> String.split "the cat on the mat", "t"
["", "he cat", " on ", "he ma", ""]
iex> String.split "the cat on the mat", -r{[ae]}
["th", " c", "t on th", " m", "t"]
iex> String.split "the cat on the mat", ~r{[ae]}, parts: 2
["th", " cat on the mat"]
iex> String.strip "\t Hello   \r\n"
"Hello"
iex> String.strip "!!!SALE!!!", ?!
"SALE"
iex> String.upcase "Jose 0rstud"
"JOSE 0RSTUD"
iex> String.valid_character? "@"
true
iex> String.valid_character? "dog"
false
```

