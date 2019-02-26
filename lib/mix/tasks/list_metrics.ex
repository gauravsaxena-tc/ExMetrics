defmodule Mix.Tasks.ListMetrics do
  use Mix.Task

  def run(_) do
    ExMetrics.DefinedMetrics.defined_metrics()
    |> Enum.each(&IO.puts/1)
  end
end
