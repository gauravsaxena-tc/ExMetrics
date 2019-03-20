defmodule ExMetrics.Plug.PageMetrics do
  @behaviour Plug
  import Plug.Conn, only: [register_before_send: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    before_time = :os.timestamp()
    ExMetrics.increment("web.request.count")

    register_before_send(conn, fn conn ->
      after_time = :os.timestamp()
      diff = :timer.now_diff(after_time, before_time)
      timing = diff / 1_000

      ExMetrics.increment("web.response.status.#{conn.status}")
      ExMetrics.timing("web.response.timing.#{conn.status}", timing)
      ExMetrics.timing("web.response.timing.page", timing)
      conn
    end)
  end
end
