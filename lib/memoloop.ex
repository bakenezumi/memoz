defmodule MemoLoop do
  @moduledoc """
    A memoize recursive loop macro.
  """

  @doc """
    The first Parameter is initial parameter of function block.
    The second Parameter is function block, it can be recursed by `recur`.

    ### Example
      
      import MemoLoop
      loop 100 do
        0 -> 0
        1 -> 1
        x -> recur(x-1) + recur(x-2)
      end #=> 354224848179261915075

  """

  defp traverse(block, f) do
    r = f.(block)
    cond do
      is_tuple(r) -> r |> Tuple.to_list |> traverse(f) |> List.to_tuple
      is_list(r) -> r |> Enum.map(&(&1 |> traverse(f)))
      true -> r
    end
  end

  defmacro loop(p, do: block) do
    quote do
      MemoZ.init(fn f -> fn x -> case x do
        unquote(block |> traverse(fn
          # `recur(args)` -> `f.(args)`
          {:recur, meta, args} -> {{:., meta, [quote do f end]}, meta, args}
          other -> other
        end))
      end end end).(unquote p)
    end
  end
end
