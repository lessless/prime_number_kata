defmodule Primify.ServerTest do
  use ExUnit.Case

  alias Primify.Server

  describe "next_number/1" do
    test "it holds state" do
      server_pid = spawn(Primify.Server, :start, [0])

      for n <- 1..10 do
        assert n + 1 == Server.next_number(server_pid)
      end
    end
  end

  describe "highest_prime/1" do
    test "it returns the highest_prime" do
      server_pid = spawn(Primify.Server, :start, [3])

      assert 3 == Server.highest_prime(server_pid)
    end
  end
end
