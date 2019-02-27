defmodule Test.ExMetrics.Plug.StatusCode do
  use ExUnit.Case
  use ExMetrics

  import Mox

  # Mox settings.
  setup :verify_on_exit!
  setup :set_mox_global

  test "records page status and response timings" do  
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:timing, fn :"web.response.timing.200", timing, [] when timing > 50 and timing < 60 -> :ok end)
    |> expect(:timing, fn :"web.response.timing.page", timing, [] when timing > 50 and timing < 60 -> :ok end)
    |> expect(:increment, fn :"web.response.status.200", 1, [] -> :ok end)
    
    {:ok, _} = HTTPoison.get("http://localhost:8300")
  end

  # test "timing for page" do  
  #   ExMetrics.Statsd.StatixConnectionMock
  #   |> expect(:timing,
  #   fn
      
  #     _, _, _ -> :ok end)

  #   {:ok, _} = HTTPoison.get("http://localhost:8300")
  # end
end
