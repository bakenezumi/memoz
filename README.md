# MemoZ

MemoZ run recursive while memoizing anonymous functions.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `memoz` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:memoz, "~> 0.1.0"}]
end
```

## Example

```elixir
MemoZ.init(fn f -> fn
  0 -> 0
  1 -> 1
  x -> f.(x-1) + f.(x-2)
end end).(100) #=> 354224848179261915075
```
