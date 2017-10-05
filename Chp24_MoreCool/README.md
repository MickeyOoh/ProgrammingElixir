## More Cool Stuff
  Elixir is packed with features that make coding a joy. This contains a smattering of them.
### Writing Your Own Sigils
	You know by now that you can create strings and regular-expression literals using sigils:
```
string = ~s{now is the time}
regex  = ~r{..h..}
```
Have you ever wished you could extend these sigils to add your own specific literal types? You can.
When you write a sigils such as ~s{..}, Elixir converts it into a call to the function *sigil_s*. It passed the function two values. The first is the string between the delimiters. The second is a list containing any lowercase letters that immediately follow the closing delimiter.

```$ elixir line_sigil.exs```

Because we import the sigil_l function inside the example module, the ~l sigil is lexically scoped to this module. Note also that Elixir performs interpolation would be performed.
The predefined sigil functions are sigil_C, sigil_c, sigil_R, sigil_r, sigil_S, sigil_s, sigil_W, and sigil_w. If you want to override one of these, you'll need to explicitly import the Kernel module and use an _except_ clause to exclude it.
 we used the heredoc syntax("""). This passes our function a multiline string with leading spaces removed. Sigil options are not supported with heredocs, so we'll switch to a regular literal syntax to play with them.

Here's the implementation of a sigil -l that takes a multiline string and returns a list containing each line as a separate string. We know -l.. is converted into a call to sigil_l, so we just write a simple function in the LineSigil module.

$ elixir line_sigil.exs

### Picking Up the Options
Let's write a sigil that enables us to specify color constants. If we say ~c{red}, we'll get 0xff0000, the RGB rerpresentation. We'll also support the option h to return an HSB value, so ~c{red}h will be {0,100,100}.

$ elixir color.exs
  Error at binary_to_atom undefined.

### Multi-app Umbrella Projects
  It is unfortuate that Erlang chose to call self-contained bundles of code _apps_. In many ways, they are closer to being shared libraries. And as your projects grow, you man find yourself wanting to split your code into multiple libraries, or apps. Fortunately, mix makes this painless.

#### Create an Umbrealla Project
We use *mix* new to create an umbrella project, passing it the --umbrella option.
```
$ mix new --umbrella eval
* creating REAME.md
* creating mix.exs
* creating apps
..
$ cd eval/apps
$ mix new line_sigil
* creating ..
$ mix new evaluator
* creating ....
...
$ cd ..
$ mix compile
==> evaluator
Compiled lib/evaluator.ex
Generated evaluator.app
==> line_sigil
Compiled lib/line_sigil.ex
Generated line_sigil.app
```


