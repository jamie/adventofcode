require "advent"
input = Advent.input.map { _1.split("").map(&:to_i) }

_input = <<~STR.split("\n").map { _1.split("").map(&:to_i) }
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
STR

# Part 1

lowpoints = []
risk = []

input.size.times do |y|
  input[0].size.times do |x|
    cell = input[y][x]
    left = input[y][x - 1] || 99
    right = input[y][x + 1] || 99
    up = begin
      input[y - 1][x]
    rescue
      99
    end
    down = begin
      input[y + 1][x]
    rescue
      99
    end
    if [left, right, up, down].min > cell
      risk << cell + 1
      lowpoints << [x, y]
    end
  end
end

puts risk.sum

# Part 2

basins = lowpoints.map do |x, y|
  seen = []
  to_check = [[x, y]]

  while (pos = to_check.pop)
    x, y = pos
    next unless (0..input.size).cover?(y)
    next unless (0..input[0].size).cover?(x)
    next if seen.include?(pos)
    next if begin
      input[y][x] || 9
    rescue
      9
    end == 9
    seen << pos

    to_check << [x + 1, y]
    to_check << [x - 1, y]
    to_check << [x, y + 1]
    to_check << [x, y - 1]
    to_check -= seen
  end

  seen.size
end

puts basins.sort.reverse.take(3).inject(&:*)
