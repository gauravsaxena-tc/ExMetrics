defmodule Test.ExMetrics.Plug.StatusCode do
  use ExUnit.Case
  use ExMetrics

  import Mox

  # Mox settings.
  setup :verify_on_exit!
  setup :set_mox_global

  [200, 404, 408, 500, 503]
  |> Enum.each(fn status_code ->
    @expected_status_code_timing_metric "web.response.timing.#{status_code}"
    @expected_status_metric "web.response.status.#{status_code}"

    test "records page status and response timings for response status #{status_code}" do
      ExMetrics.Statsd.StatixConnectionMock
      |> expect(:timing, fn @expected_status_code_timing_metric, timing, []
                            when timing >= 50 and timing < 60 ->
        :ok
      end)
      |> expect(:timing, fn "web.response.timing.page", timing, []
                            when timing >= 50 and timing < 60 ->
        :ok
      end)
      |> expect(:increment, fn @expected_status_metric, 1, [] -> :ok end)

      {:ok, _} = HTTPoison.get("http://localhost:8300/#{unquote(status_code)}")
    end
  end)
end
