defmodule ExMetrics.Application do
  use Application

  def start(_type, args) do
    children = children(args)

    opts = [strategy: :one_for_one, name: ExMetrics.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp children(env: :test) do
    children(env: :prod) ++
      [
        Plug.Cowboy.child_spec(
          scheme: :http,
          plug: Test.Support.FakePlugApp,
          options: [port: 8300]
        )
      ]
  end

  defp children(_) do
    [
      :poolboy.child_spec(:statsd_worker, poolboy_config())
    ]
  end

  defp poolboy_config do
    [
      {:name, {:local, :statsd_worker}},
      {:worker_module, ExMetrics.Statsd.Worker},
      {:size, Application.get_env(:ex_metrics, :worker_pool_size)},
      {:max_overflow, Application.get_env(:ex_metrics, :worker_max_overflow)}
    ]
  end
end
