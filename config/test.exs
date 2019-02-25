use Mix.Config

config :ex_metrics,
  dimensions: [environment: "test", region: "eu-west-1", app_name: "some-app-name"],
  send_metrics: false
