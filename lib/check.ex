defmodule Primify.Check do
  def highest_prime_in_range(n..m) do
    result =
      n..m
      |> Enum.map(fn x -> {x, is_prime?(x)} end)
      |> Enum.filter(fn {x, is_prime} -> is_prime == true end)
      |> List.last()

    elem(result, 0)
  end

  def is_prime?(0) do
    false
  end

  def is_prime?(1) do
    true
  end

  def is_prime?(p) do
    r = :random.uniform(p - 1)
    t = mpow(r, p - 1, p)

    if t == 1 do
      true
    else
      false
    end
  end

  defp mpow(n, 1, _) do
    n
  end

  defp mpow(n, k, m) do
    mpow(rem(k, 2), n, k, m)
  end

  defp mpow(0, n, k, m) do
    x = mpow(n, div(k, 2), m)
    rem(x * x, m)
  end

  defp mpow(_, n, k, m) do
    x = mpow(n, k - 1, m)
    rem(x * n, m)
  end
end
