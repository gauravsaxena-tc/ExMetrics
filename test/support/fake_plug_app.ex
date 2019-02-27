defmodule Test.Support.FakePlugApp do
  
  use Plug.Router
  plug ExMetrics.Plug.PageMetrics

  plug :match
  plug :dispatch

  get _ do
    :timer.sleep(50)
    conn
    |> send_resp(200, "Hey!")
  end
end
