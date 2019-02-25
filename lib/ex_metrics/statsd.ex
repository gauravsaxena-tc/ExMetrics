defmodule ExMetrics.Statsd do
  alias ExMetrics.{Config, Statsd}

  def timing(key, value) do
    Statsd.Worker.record({:timing, [key, value, options()]})
  end

  defp options do
    [tags: Config.tags()]
  end
end
