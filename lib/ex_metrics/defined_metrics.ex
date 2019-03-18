defmodule ExMetrics.DefinedMetrics do
  require Logger

  def defined?(metric) do
    metric in defined_metrics()
  end

  def defined_metrics do
    client_defined_metrics() ++ default_metrics()
  end

  def default_metrics do
    response_code_metrics() ++ timing_metrics()
  end

  defp timing_metrics do
    ([:page] ++ status_codes())
    |> Enum.map(fn status_code -> "web.response.timing.#{status_code}" end)
  end

  defp response_code_metrics do
    status_codes()
    |> Enum.map(fn status_code -> "web.response.status.#{status_code}" end)
  end

  defp status_codes do
    Enum.to_list(200..599)
  end

  def client_defined_metrics do
    Application.get_env(:ex_metrics, :metrics, [])
  end

  def log_if_undefined_metric(metric) do
    if not defined?(metric) do
      Logger.info("""
      Metric '#{metric}' is not defined in your config.
      Define it like this:
      config :ex_metrics, metrics: ["#{metric}"]
      """)
    end
  end
end
