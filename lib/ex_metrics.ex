defmodule ExMetrics do
  alias ExMetrics.DefinedMetrics

  @stat_types [:timing, :increment, :decrement, :gauge, :set, :histogram]

  @stat_types
  |> Enum.each(fn stat_type ->
    def unquote(stat_type)(metric, value \\ 1, opts \\ []) do
      DefinedMetrics.log_if_undefined_metric(metric)

      :poolboy.transaction(
        :statsd_worker,
        fn pid ->
          GenServer.cast(pid, {unquote(stat_type), [metric, Kernel.trunc(value), opts]})
        end,
        Application.get_env(:ex_metrics, :worker_timeout)
      )
    end
  end)

  defmacro timeframe(key, do: yield) do
    quote do
      before_time = :os.timestamp()
      result = unquote(yield)
      after_time = :os.timestamp()
      diff = :timer.now_diff(after_time, before_time)

      ExMetrics.timing(unquote(key), diff / 1_000)
      result
    end
  end

  defmacro __using__(_) do
    quote do
      import ExMetrics
    end
  end
end
