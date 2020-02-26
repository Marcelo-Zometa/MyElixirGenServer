defmodule MygenserverTest do
  use ExUnit.Case
  doctest Mygenserver

  test "greets the world" do
    assert Mygenserver.hello() == :world
  end
end
