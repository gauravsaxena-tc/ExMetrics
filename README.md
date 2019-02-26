# ExMetrics

This module is designed to abstract the way we store our metrics.

## Mix tasks
#### View defined metrics
`mix list_metrics`

## Configure ExMetrics
Example:
```
config :ex_metrics,
  metrics: [:a_metric, "a_metric"],
  send_metrics: Boolean,
  raise_on_undefined_metrics: Boolean (recommended to be set to true on test & dev. defaults to false)
```
