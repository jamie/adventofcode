input =
  Advent.read_lines("2020/06/input")
  # Split by double-newlines
  |> Enum.chunk_by(&(&1 == ""))
  |> Enum.reject(&(&1 == [""]))

# Part 1

input
|> Enum.map(fn batch ->
  batch
  |> Enum.join
  |> String.codepoints
  |> Enum.uniq
  |> Enum.count
end)
|> Enum.sum
|> IO.puts

# Part 2

input
|> Enum.map(fn batch ->
  batch
  |> Enum.map(&(MapSet.new(&1 |> String.codepoints)))
  |> Enum.reduce(&(MapSet.intersection(&1, &2)))
  |> MapSet.size
end)
|> Enum.sum
|> IO.puts
