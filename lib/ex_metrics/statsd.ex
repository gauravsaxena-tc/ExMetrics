defmodule ExMetrics.Statsd do
  alias ExMetrics.Statsd

  def timing(key, value) do
    Statsd.Worker.record({:timing, [key, value]})
  end
end
