# ExMetrics

This module is designed to abstract the way we store our metrics.

## Configure ExMetrics
```
config :ex_metrics,
  dimensions: Keyword = [environment: "test", region: "eu-west-1", app_name: "some-app-name"],
  send_metrics: Boolean = false | false
```
