defmodule Primify.Server do
  alias Primify.Check

  @initial_state %{highest_prime: nil, current_number: nil}

  def start(n) do
    loop(%{@initial_state | current_number: n})
  end

  defp loop(state) do
    receive do
      {:next_number, pid} ->
        state = increment_current_number(state)
        send(pid, state.current_number)
        loop(state)

      {:highest_prime, pid} ->
        state = check_if_prime(state, state.current_number)
        send(pid, state.highest_prime)
        loop(state)
    end
  end

  def highest_prime(pid) do
    send(pid, {:highest_prime, self()})

    receive do
      number -> number
    after
      5000 -> raise "Server not responding"
    end
  end

  def check_if_prime(state, n) do
    case Check.is_prime?(n) do
      true -> %{state | highest_prime: n}
      false -> state
    end
  end

  defp increment_current_number(state) do
    %{state | current_number: state.current_number + 1}
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
