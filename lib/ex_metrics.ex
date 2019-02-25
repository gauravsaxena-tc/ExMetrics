defmodule ExMetrics do
  alias ExMetrics.{Config}

  @stat_types [:timing, :increment, :decrement, :gauge, :set, :histogram]

  @stat_types
  |> Enum.each(fn stat_type ->
    def unquote(stat_type)(key, value, opts \\ []) do
      ExMetrics.Statsd.Worker.record({unquote(stat_type), [key, value, options(opts)]})
    end
  end)

  defp options(opts) do
    Keyword.merge(opts, tags: Config.tags())
  end

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
