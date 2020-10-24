defmodule Primify.Server do
  @initial_state %{highest_prime: nil, next_number: nil}

  def start(n) do
    state = check_if_prime(@initial_state, n)
    state = increment_next_number(%{state | next_number: n})

    loop(state)
  end

  defp loop(state) do
    receive do
      {:next_number, pid} ->
        state = increment_next_number(state)
        send(pid, state.next_number)
        loop(state)

      {:highest_prime, pid} ->
        state = check_if_prime(state, state.next_number)
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
    case Primify.is_prime?(n) do
      true -> %{state | highest_prime: n}
      false -> state
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
