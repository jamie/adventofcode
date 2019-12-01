require "advent"
input = Advent.input(2016, 18)

# Part 1
row = input.split(//)

safe = 0
40.times do
  safe += row.count(".")

  row = row.size.times.map do |i|
    if i == 0
      row[1]
    elsif i == row.size - 1
      row[-2]
    elsif (row[i - 1] == "^" && row[i + 1] == ".") ||
          (row[i - 1] == "." && row[i + 1] == "^")
      "^"
    else
      "."
    end
  end
end

puts safe

# Part 2
row = input.split(//)

safe = 0
400000.times do
  safe += row.count(".")

  row = row.size.times.map do |i|
    if i == 0
      row[1]
    elsif i == row.size - 1
      row[-2]
    elsif (row[i - 1] == "^" && row[i + 1] == ".") ||
          (row[i - 1] == "." && row[i + 1] == "^")
      "^"
    else
      "."
    end
  end
end

puts safe
