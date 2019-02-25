defmodule Test.ExMetrics do
  use ExUnit.Case
  use ExMetrics

  import Mox

  # Mox settings.
  setup :verify_on_exit!
  setup :set_mox_global

  @expected_tags [tags: ["environment:test", "region:eu-west-1", "app_name:some-app-name"]]
  @expected_tags_with_sample_rate Keyword.merge([sample_rate: 0.5], @expected_tags)
  def timing_mock("time-await", timing, @expected_tags) when timing > 200 and timing < 205, do: :ok

  test "can record timings" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:timing, fn "test string", 10, @expected_tags -> :ok end)

    assert :ok == ExMetrics.timing("test string", 10)
  end

  test "can specify statix options" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:increment, fn "test string", 5, @expected_tags_with_sample_rate -> :ok end)

    assert :ok == ExMetrics.increment("test string", 5, sample_rate: 0.5)
  end

  test "can increment metrics" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:increment, fn "test string", 5, @expected_tags -> :ok end)

    assert :ok == ExMetrics.increment("test string", 5)
  end

  test "can decrement metrics" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:decrement, fn "test string", 5, @expected_tags -> :ok end)

    assert :ok == ExMetrics.decrement("test string", 5)
  end

  test "can gauge metrics" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:gauge, fn "test string", 5, @expected_tags -> :ok end)

    assert :ok == ExMetrics.gauge("test string", 5)
  end

  test "can set metrics" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:set, fn "test string", 5, @expected_tags -> :ok end)

    assert :ok == ExMetrics.set("test string", 5)
  end

  test "can record histogram" do
    ExMetrics.Statsd.StatixConnectionMock
    |> expect(:histogram, fn "test string", 5, @expected_tags -> :ok end)

    assert :ok == ExMetrics.histogram("test string", 5)
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
