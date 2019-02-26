defmodule Test.ExMetrics do
  use ExUnit.Case
  use ExMetrics

  import Mox

  # Mox settings.
  setup :verify_on_exit!
  setup :set_mox_global

  @expected_options []
  @expected_options_with_sample_rate Keyword.merge([sample_rate: 0.5], @expected_options)
  def timing_mock("time-await", timing, @expected_options) when timing > 200 and timing < 205, do: :ok

  test "can record timings" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:timing, fn "test-metric-name", 10, @expected_options -> :ok end)

    assert :ok == ExMetrics.timing("test-metric-name", 10)
  end

  test "can specify statix options" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:increment, fn "test-metric-name", 5, @expected_options_with_sample_rate -> :ok end)

    assert :ok == ExMetrics.increment("test-metric-name", 5, sample_rate: 0.5)
  end

  test "can increment metrics" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:increment, fn "test-metric-name", 5, @expected_options -> :ok end)

    assert :ok == ExMetrics.increment("test-metric-name", 5)
  end

  test "can decrement metrics" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:decrement, fn "test-metric-name", 5, @expected_options -> :ok end)

    assert :ok == ExMetrics.decrement("test-metric-name", 5)
  end

  test "can gauge metrics" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:gauge, fn "test-metric-name", 5, @expected_options -> :ok end)

    assert :ok == ExMetrics.gauge("test-metric-name", 5)
  end

  test "can set metrics" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:set, fn "test-metric-name", 5, @expected_options -> :ok end)

    assert :ok == ExMetrics.set("test-metric-name", 5)
  end

  test "can record histogram" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:histogram, fn "test-metric-name", 5, @expected_options -> :ok end)

    assert :ok == ExMetrics.histogram("test-metric-name", 5)
  end

  test "can time snippets of code" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:timing, &timing_mock/3)

    result =
      ExMetrics.timeframe "time-await" do
        :timer.sleep(200)
        "pass on this result"
      end

    assert result == "pass on this result"
  end
end
