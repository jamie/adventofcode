input =
  Advent.read_lines("2020/04/input")
  # Split by double-newlines
  |> Enum.chunk_by(&(&1 == ""))
  |> Enum.reject(&(&1 == [""]))
  # Join to a single value per record
  |> Enum.map(&Enum.join(&1, " "))
  # Parse k:v into a map
  |> Enum.map(fn line ->
    line
    |> String.split(" ")
    |> Enum.map(&(String.split(&1, ":") |> List.to_tuple()))
    |> Map.new()
  end)

# TODO: Do this more robustly parsing the
#       above maps into a proper struct.
fields =
  ["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"]
  |> Enum.sort()

# Part 1
input
|> Enum.filter(fn record ->
  keys = record |> Map.keys()

  fields
  |> Enum.all?(fn field ->
    Enum.member?(keys, field)
  end)
end)
|> Enum.count()
|> IO.puts()

# Part 2

valid_ecl = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

input
|> Enum.filter(fn record ->
  keys = record |> Map.keys()

  fields
  |> Enum.all?(fn field ->
    Enum.member?(keys, field)
  end)
end)
|> Enum.filter(fn record ->
  (%{
     "byr" => byr,
     "iyr" => iyr,
     "eyr" => eyr,
     "hgt" => hgt,
     "hcl" => hcl,
     "ecl" => ecl,
     "pid" => pid
   } = record) &&
    Enum.member?(1920..2002, String.to_integer(byr)) &&
    Enum.member?(2010..2020, String.to_integer(iyr)) &&
    Enum.member?(2020..2030, String.to_integer(eyr)) &&
    Enum.member?(valid_ecl, ecl) &&
    Regex.match?(~r/^#[[:xdigit:]]{6}$/, hcl) &&
    Regex.match?(~r/^[[:digit:]]{9}$/, pid) &&
    case Regex.run(~r/([[:digit:]]+)([[:alpha:]]+)/, hgt, capture: :all_but_first) do
      [cm, "cm"] -> Enum.member?(150..193, String.to_integer(cm))
      [inch, "in"] -> Enum.member?(59..76, String.to_integer(inch))
      _ -> false
    end
end)
|> Enum.count()
|> IO.puts()
