defmodule ExMetrics.Statsd.StatixConnectionMock do
  alias ExMetrics.Statsd.StatixConnection
  @behaviour StatixConnection

  @impl StatixConnection
  def init(), do: :ok

  @impl StatixConnection
  def connected?(), do: true

  @impl StatixConnection
  def decrement(_name, _value \\ 1, _opts \\ []), do: :ok

  @impl StatixConnection
  def gauge(_name, _value, _opts \\ []), do: :ok

  @impl StatixConnection
  def increment(_name, _value \\ 1, _opts \\ []), do: :ok

  @impl StatixConnection
  def set(_name, _value, _opts \\ []), do: :ok

  @impl StatixConnection
  def timing(_name, _value, _opts \\ []), do: :ok

  @impl StatixConnection
  def histogram(_name, _value, _opts \\ []), do: :ok
end
