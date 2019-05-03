defmodule Test.Support.Helper do
  def wait_for_cast do
    # get the PID of a worker child in the pool
    pid = :poolboy.checkout(:statsd_worker)

    # get_state waits for the current process to
    # finish it's action.
    :sys.get_state(pid)

    # check the worker back into the pool
    :poolboy.checkin(:statsd_worker, pid)
  end
end
