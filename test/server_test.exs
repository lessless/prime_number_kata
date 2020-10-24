defmodule Primify.ServerTest do
  use ExUnit.Case

  alias Primify.Server

  describe "next_number/1" do
    test "returns a number to check whether its prime or not" do
      assert Server.next_number() == 1
    end

    test "increments numbers" do
      spawn(Primify.Server, :start, [1, self()])

      result =
        receive do
          %{highest_prime: 1, next_number: 2} -> true
          _ -> false
        end

      assert result
    end

    test "it holds state" do
      server_pid = spawn(Primify.Server, :start, [1, self()])

      for n <- 1..10 do
        send(server_pid, :next_number)

        m = n + 1

        result =
          receive do
            ^m -> true
            _ -> false
          after
            5 ->
              IO.puts(:stderr, "No message in 5 milliseconds")
          end

        assert result == true
      end
    end
  end
end
