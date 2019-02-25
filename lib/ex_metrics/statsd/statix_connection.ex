defmodule ExMetrics.Statsd.StatixConnection do
  use Statix, runtime_config: true

  @callback init() :: :ok
  @callback connected?() :: true
  @callback decrement(String.t(), integer(), keyword()) :: atom()
  @callback gauge(String.t(), integer(), keyword()) :: atom()
  @callback increment(String.t(), integer(), keyword()) :: atom()
  @callback set(String.t(), integer(), keyword()) :: atom()
  @callback timing(String.t(), integer(), keyword()) :: atom()
  @callback histogram(String.t(), integer(), keyword()) :: atom()

  def init do
    unless connected?() do
      connect()
    end

    :ok
  end

  def connected? do
    case Process.whereis(ExMetrics.StatixConnection) do
      nil ->
        false

      _ ->
        true
    end
  end
end
