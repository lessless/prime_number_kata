defmodule Primify.Server do
  @state %{highest_prime: 1, next_number: 2}

  def start(n \\ 1, caller_pid) do
    send(caller_pid, %{@state | highest_prime: n})
  end

  def next_number() do
    1
  end

  def next_number() do
  end
end
