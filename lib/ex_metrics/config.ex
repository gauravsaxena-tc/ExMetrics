defmodule ExMetrics.Config do
  def send_metrics? do
    Application.fetch_env!(:ex_metrics, :send_metrics)
  end

  def statsd_host do
    Application.get_env(:ex_metrics, :statsd_host, "localhost:8125")
  end

  def tags do
    Application.fetch_env!(:ex_metrics, :dimensions)
    |> Enum.map(fn {key, value} -> "#{key}:#{value}" end)
  end
end
