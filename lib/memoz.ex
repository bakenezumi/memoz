defmodule MemoZ do
  @moduledoc """
    MemoZ run recursive while memoizing anonymous functions.
  """

  @doc """
    `init` to your anonymous recursive function, will make memoize.

    ### Example

      MemoZ.init(fn f ->
        fn
          0 -> 0
          1 -> 1
          x -> f.(x-1) + f.(x-2)
        end
      end).(100) #=> 354224848179261915075

  """

  def init(f) do
    fn x ->
      {:ok, pid} = Agent.start_link &Map.new/0
      try do
        fix(pid, f).(x)
      after
        Agent.stop pid
      end
    end
  end

  defp fix(pid, f) do
    fn x ->
      x.(x)
    end.(
      fn x ->
        f.(&(get_or_else_update(pid, &1, fn -> x.(x).(&1) end)))
      end
    )
  end

  defp get_or_else_update(pid, k, f) do
    case Agent.get(pid, &Map.get(&1, k)) do
      nil ->
        v = f.()
        Agent.update(pid, &Map.put(&1, k, v))
        v
      v -> v
    end    
  end
end