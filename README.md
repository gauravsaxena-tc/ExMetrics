# ExMetrics

This module is designed to abstract the way we store our metrics.

## Mix tasks
#### View defined metrics
`mix list_metrics`

## Configure ExMetrics
Example:
```
config :ex_metrics,
  metrics: ["metric_one", "another_metric"],
  send_metrics: Boolean
```
