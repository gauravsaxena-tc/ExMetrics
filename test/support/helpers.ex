defmodule Test.Support.Helper do
  def wait_for_cast(mod) do
    pid = GenServer.whereis(mod)
    :sys.get_state(pid)
  end
end
