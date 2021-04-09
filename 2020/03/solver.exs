input = Advent.read_lines("2020/03/input")

# Part 1
input
|> Enum.with_index()
|> Enum.filter(fn {line, y} ->
  x = rem(y * 3, String.length(line))
  String.at(line, x) == "#"
end)
|> Enum.count()
|> IO.puts()

# Part 2
trees_on_path = fn input, dx, dy ->
  input
  |> Enum.chunk_every(dy)
  |> Enum.with_index()
  |> Enum.filter(fn {[line | _], y} ->
    x = rem(y * dx, String.length(line))
    String.at(line, x) == "#"
  end)
  |> Enum.count()
end

[[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
|> Enum.map(fn [dx, dy] ->
  trees_on_path.(input, dx, dy)
end)
|> Enum.reduce(&(&1 * &2))
|> IO.puts()
