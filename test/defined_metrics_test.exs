defmodule Test.ExMetrics.DefinedMetrics do
  use ExUnit.Case
  alias ExMetrics.DefinedMetrics

  setup do
    Application.put_env(:ex_metrics, :raise_on_undefined_metrics, true)
  end

  test "raises error" do
    assert_raise(
      RuntimeError,
      "Metric 'undefined_metric_name' is not defined in your config.\nDefine it like this:\nconfig :ex_metrics, metrics: [:undefined_metric_name]\n",
      fn -> DefinedMetrics.raise_if_undefined_metric!(:undefined_metric_name) end
    )
  end

  describe "option raise_on_undefined_metrics = false" do
    setup do
      Application.put_env(:ex_metrics, :raise_on_undefined_metrics, false)
    end

    test "does not raise error" do
      DefinedMetrics.raise_if_undefined_metric!(:undefined_metric_name)
    end
  end
end
