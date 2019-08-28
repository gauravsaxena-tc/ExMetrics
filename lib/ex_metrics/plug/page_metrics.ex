defmodule ExMetrics.Plug.PageMetrics do
  @behaviour Plug
  import Plug.Conn, only: [register_before_send: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    metric_name = get_metric_name(conn)
    before_time = :os.timestamp()

    register_before_send(conn, fn conn ->
      after_time = :os.timestamp()
      diff = :timer.now_diff(after_time, before_time)
      time_ms = diff / 1_000

      ExMetrics.increment(metric_name <> ".#{conn.status}" <> ".count")
      ExMetrics.timing(metric_name <> ".#{conn.status}" <> ".time", time_ms)
      conn
    end)
  end

  @spec get_metric_name(Plug.Conn.t()) :: String.t()
  defp get_metric_name(conn) do
    metric_name_from_request_path(conn.request_path)
  end

  @spec metric_name_from_request_path(String.t()) :: String.t()
  defp metric_name_from_request_path("/"), do: ".root"

  defp metric_name_from_request_path(request_path) do
    request_path
    |> String.replace("/", ".")
    |> String.replace(~r/\.+/, ".")
    |> String.trim_trailing(".")
    |> String.replace(":", "")
  end
end
