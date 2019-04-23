defmodule Mix.Tasks.Benchmark do
  use Mix.Task
  use ExMetrics

  size = 200 * 1024
  @data :crypto.strong_rand_bytes(size) |> Base.encode64() |> binary_part(0, size)
  def run(_) do
    {:ok, _started} = Application.ensure_all_started(:ex_metrics)

    Benchee.run(
      %{
        "increment" => fn ->
          ExMetrics.increment("benchmark.metric")
        end,
        "timeframe returns data" => fn ->
          ExMetrics.timeframe "benchmark.metric" do
            @data
          end
        end
      },
      time: 10,
      memory_time: 2
    )
  end
end
