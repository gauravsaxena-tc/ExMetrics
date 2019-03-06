defmodule Test.Support.FakePlugApp do
  use Plug.Router
  plug(ExMetrics.Plug.PageMetrics)

  plug(:match)
  plug(:dispatch)

  get "/:status" do
    :timer.sleep(50)

    conn
    |> send_resp(String.to_integer(status), "Hey!")
  end
end
