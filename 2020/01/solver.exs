# require "advent"
# input = Advent.input

{:ok, input} = File.read("2020/01/input")
numbers = input
|> String.split("\n", trim: true)
|> Enum.map(&String.to_integer/1)

# numbers = [
#   1721,
#   979,
#   366,
#   299,
#   675,
#   1456
# ]

# Part 1

## Explicit looping

# numbers
# |> Enum.with_index
# |> Enum.each(fn({x, i}) ->
#   numbers
#   |> Enum.slice((i+1)..-1)
#   |> Enum.each(fn(y) ->
#     if x + y == 2020 do
#       IO.puts(x * y)
#     end
#   end)
# end)

## List comprehensions!

for x <- numbers,
    y <- numbers,
    x <= y,
    x + y == 2020,
    do: IO.puts(x * y)

# Part 2

for x <- numbers,
    y <- numbers,
    z <- numbers,
    x <= y,
    y <= z,
    x + y + z == 2020,
    do: IO.puts(x * y * z)
