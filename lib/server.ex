defmodule Primify.Server do
  @initial_state %{highest_prime: nil, next_number: nil}

  def start(n) do
    state = increment_next_number(%{@initial_state | next_number: n})

    loop(state)
  end

  defp loop(state) do
    receive do
      {:next_number, pid} ->
        state = increment_next_number(state)
        send(pid, state.next_number)
        loop(state)
    end
  end

  defp increment_next_number(state) do
    %{state | next_number: state.next_number + 1}
  end

  def next_number(pid) do
    send(pid, {:next_number, self()})

    receive do
      number -> number
    after
      5 ->
        raise "Server process is not responding"
    end
  end
end
