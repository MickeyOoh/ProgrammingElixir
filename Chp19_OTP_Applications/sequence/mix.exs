defmodule Sequence.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sequence,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Sequence.Application, []},   # the main entry point for the app.
      #mod: {Sequence.Application, 456}, # the main entry point for the app.
      #mod: { Sequence, [] },   # the main entry point for the app.
      registered: [ Sequence.Server ],
      env:      [initial_number: 456],
      #registered: [ :sequence ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:exrm, "~> 1.0.6"}
    ]
  end
end
