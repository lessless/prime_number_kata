defmodule Primify.Worker do
  alias Primify.Server
  alias Primify.Check

  def start(server_pid) do
    number = Server.next_number(server_pid)

    if Check.is_prime?(number) do
      send(server_pid, {:is_prime, number})
    end
  end
end
