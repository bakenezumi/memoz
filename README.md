# MemoZ

MemoZ run recursive while memoizing anonymous function.
MemoLoop is a macro to simplify it.

## Installation

Adding `memoz` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:memoz, "~> 0.1.0"}]
end
```

## Example

function version

```elixir
MemoZ.init(fn f -> fn
  0 -> 0
  1 -> 1
  x -> f.(x-1) + f.(x-2)
end end).(100) #=> 354224848179261915075
```

macro version

```elixir
import MemoLoop
loop 100 do
  0 -> 0
  1 -> 1
  x -> recur(x-1) + recur(x-2)
end #=> 354224848179261915075
```
