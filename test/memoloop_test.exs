defmodule MemoLoopTest do
  use ExUnit.Case
  doctest MemoLoop

  test "fibonacci" do
    assert (MemoLoop.loop 10 do
      0 -> 0
      1 -> 1
      x -> recur(x-1) + recur(x-2)
    end) == 55
  end
end
