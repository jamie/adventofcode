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

numbers
|> Enum.with_index
|> Enum.each(fn({x, i}) ->
  numbers
  |> Enum.slice((i+1)..-1)
  |> Enum.each(fn(y) ->
    if x + y == 2020 do
      IO.puts(x*y)
    end
  end)
end)

# Part 2

numbers
|> Enum.with_index
|> Enum.each(fn({x, i}) ->
  numbers
  |> Enum.slice((i+1)..-1)
  |> Enum.with_index
  |> Enum.each(fn({y, j}) ->
    numbers
    |> Enum.slice((i+j+1)..-1)
    |> Enum.each(fn(z) ->
      if x + y + z == 2020 do
        IO.puts(x*y*z)
      end
    end)
  end)
end)
