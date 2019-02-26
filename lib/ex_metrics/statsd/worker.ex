defmodule ExMetrics.Statsd.Worker do
  use Agent

  alias ExMetrics.Config

  def start_link() do
    set_up_statix()

    connection =
      case Config.send_metrics?() do
        true -> ExMetrics.Statsd.StatixConnection
        _ -> ExMetrics.Statsd.StatixConnectionMock
      end

    connection.init()

    Agent.start_link(fn -> connection end, name: __MODULE__)
  end

  def record({statix_command, [name, value, opts]}) do
    Agent.get(__MODULE__, fn connection ->
      apply(connection, statix_command, [name, value, opts])
    end)
  end

  defp set_up_statix do
    Application.put_env(:statix, :host, Config.statsd_host())
    Application.put_env(:statix, :port, Config.statsd_port())
  end
end
