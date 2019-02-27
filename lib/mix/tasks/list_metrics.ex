defmodule Mix.Tasks.ListMetrics do
  use Mix.Task

  def run(_) do
    IO.puts """
    ############################################################
    Default metrics:
    #{display default_metrics()}

    Custom defined metrics:
    #{display ExMetrics.DefinedMetrics.client_defined_metrics()}
    ############################################################
    """
  end

  defp default_metrics() do
    ["web.timing.page", "web.response.timing.<200..599>", "web.response.status.<200..599>"]
  end

  defp display(metrics_list) do
    metrics_list
    |> Enum.chunk_every(3)
    |> Enum.map(&display_row/1)
    |> Enum.join("\n")
  end

  defp display_row(row_of_metrics) do
    row_of_metrics
    |> Enum.join("     ")
  end
end
