Organizing a Project
-----

The Project: Fetch Issues from GitHub
-----
Github provides a nice web API for fetching issues. Simply issue a GET request to
[https://api.github.com/repos/user/project/issues](https://api.github.com/repos/user/project/issues)

and you'll get back a JSON list of issues. We'll reformat this, sort it, and filter out the oldest n, presenting the result as a table:

How Our Code Will do it
----
Our program will run from the command line. We(ll need to pass in a GitHub ueser name, a project name, and an optional count. This means we'll need some basic command-line parsing.
We'll need to access GitHub as an HTTP client, so we'll have to find a library that gives us the client side of HTTP. The response that comes back will be in JSON, so we'll need a library that handles JSON, too. We'll need to be able to sort the resulting structure. And finally, we'll need to lay out selected fields in a table.

*issues elixir-lang elixir*

|--------------------|
| parse              |
|--------------------|

*{ user, project, n}*
*{ "elixir-lang", "elixir", 4}*

|--------------------|
| fetch from Github  | Issues.GithubIssues.fetch(user, project)
|--------------------|

*github json*

|--------------------|
| convert            |
|--------------------|
`internal representation`

|--------------------|
| sort               |
|--------------------|
`sorted`

|--------------------|
| first(n)           |
|--------------------|
`data subset`

|--------------------|
| table format       |
|--------------------|
`pretty table`

Task: Use Mix to Create Our New Project
-----

```
$ mix help
$ mix help deps
$ mix new issues


$ git init
$ git add .
$ git commit -m "Initial commit of new project"
```

* .gitignore
   Lists the files and directories generated as by-products of the build and not to be saved in the repository
* README.md
   A place to put a description of your project
* config/
   Eventually we'll put some application-specific configuration here.
* lib/
   This is where our project's source lives. Mix has already added a top level module
* mix.exs
   This source file contains our project's configuration options. 
* test/
  
	 

Application Configuration
-----
Before we move on, there's one little tweak I'd like to make. The *issue_url* function hardcodes the GitHub URL. Let's make this configurable.
Remember that whwn we created the project using *mix new*. it added a *config/* directory containing *config.exs*. That file stores application-level configuration.
It should start with the line.
```
use Mix.Config
```
We then write configuration information for each of the applications in our project. Here we're configuring the Issues application, so we write this code:
```config/config.exs
use Mix.Config
config :issues, github_url: "https://api.github.com"
```
Each *config* line adds one or more *key/value* pairs to the given application's *environment*. If you have multiple lines for the same application, they accumulate, with duplicate keys in later lines overriding vlaues from earlier ones.

