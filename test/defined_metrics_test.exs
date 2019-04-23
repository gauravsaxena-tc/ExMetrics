defmodule Test.ExMetrics.DefinedMetrics do
  use ExUnit.Case
  alias ExMetrics.DefinedMetrics
  import ExUnit.CaptureLog
  require Logger

  @metric "undefined_metric_name"
  @log_msg "Metric 'undefined_metric_name' is not defined in your config.\nDefine it like this:\nconfig :ex_metrics, metrics: [\"undefined_metric_name\"]\n"

  test "logs unspecified metric" do
    assert capture_log(fn ->
             DefinedMetrics.log_if_undefined_metric(@metric)
           end) =~ @log_msg
  end

  test "logs unspecified metric when using ExMetrics library interface" do
    assert capture_log(fn ->
             ExMetrics.increment(@metric)
           end) =~ @log_msg
  end
end
