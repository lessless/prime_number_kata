defmodule PrimifyTest do
  use ExUnit.Case

  describe "is_prime?/1" do
    test "returns true or false if the number is prime or not" do
      for _ <- 0..10_000 do
        assert Primify.is_prime?(7103)
      end
    end
  end
end
