defmodule ExMetrics.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_metrics,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExMetrics.Application, [env: Mix.env()]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.4", only: :test},
      {:plug_cowboy, "~> 2.0.1", only: :test},
      {:mox, "~> 0.5", only: :test},
      {:plug, ">= 1.7.0"},
      {:statix, ">= 1.1.0"},
      {:benchee, ">= 1.0.1", only: :dev}
    ]
  end
end
