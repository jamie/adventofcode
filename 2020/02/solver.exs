input =
  Advent.read_lines("2020/02/input")
  |> Enum.reject(&(&1 == ""))
  |> Enum.map(fn line ->
    Regex.run(~r/(\d+)-(\d+) (.*): (.*)/, line, capture: :all_but_first)
  end)

# Part 1
input
|> Enum.filter(fn [smin, smax, char, password] ->
  min = String.to_integer(smin)
  max = String.to_integer(smax)

  freq =
    password
    |> String.graphemes()
    |> Enum.count(fn c -> c == char end)

  Enum.member?(min..max, freq)
end)
|> Enum.count()
|> IO.puts()

# Part 2
input
|> Enum.filter(fn [slo, shi, char, password] ->
  lo = String.to_integer(slo) - 1
  hi = String.to_integer(shi) - 1

  chars = password |> String.graphemes()

  1 ==
    [Enum.at(chars, lo), Enum.at(chars, hi)]
    |> Enum.count(fn c -> c == char end)
end)
|> Enum.count()
|> IO.puts()
