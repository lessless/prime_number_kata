defmodule Primify.CheckTest do
  use ExUnit.Case, async: true

  alias Primify.Check

  describe "is_prime?/1" do
    test "returns true or false if the number is prime or not" do
      for _ <- 0..10_000 do
        assert Check.is_prime?(7103)
      end
    end
  end

  describe "highest_prime_in_range/1" do
    test "returns the highest_prime in a range" do
      assert 7 = Check.highest_prime_in_range(0..10)
    end
  end
end
