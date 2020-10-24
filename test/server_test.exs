defmodule Primify.ServerTest do
  use ExUnit.Case

  alias Primify.Server

  describe "next_number/1" do
    test "returns a number to check whether its prime or not" do
      assert Server.next_number() == 1
    end

    test "increments numbers" do
      raise "not implemented"
    end
  end
end
