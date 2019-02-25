defmodule ExMetrics.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_metrics,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExMetrics.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mox, "~> 0.5", only: :test},
      {:plug, ">= 1.7.0"},
      {:statix, ">= 1.1.0"}
    ]
  end
end
