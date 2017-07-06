defmodule MemoZTest do
  use ExUnit.Case
  doctest MemoZ

  test "fibonacci" do
    assert MemoZ.init(fn f -> fn
      0 -> 0
      1 -> 1
      x -> f.(x-1) + f.(x-2)
    end end).(10) == 55
  end
end
