defmodule Primify.WorkerTest do
  use ExUnit.Case, async: true

  alias Primify.Worker

  defmodule FakeServer do
    def start(number, test_pid) do
      loop(number, test_pid)
    end

    def loop(number, test_pid) do
      receive do
        {:next_number, worker_pid} ->
          send(worker_pid, number)
          loop(number, test_pid)
        {:is_prime, number} ->
          send(test_pid, {:is_prime, number})
      end
    end
  end

  test "it pulls prime number to check from a server" do
    server_pid = spawn(FakeServer, :start, [3, self()])
    Worker.start(server_pid)
    assert_receive {:is_prime, 3}, 500
  end
end
