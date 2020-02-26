defmodule MygenserverTest do
  use ExUnit.Case
  doctest ServerProcess

  test "greets the world" do
    assert ServerProcess.hello() == :world
  end

  test "trying this assert thing" do
    assert 2 != 3
  end
end
