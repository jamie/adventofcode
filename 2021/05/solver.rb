require "advent"
input = Advent.input

inpxut = <<~STR.split("\n")
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
STR

# Part 1

grid = {}

input.each do |line|
  line =~ /(\d+),(\d+) -> (\d+),(\d+)/
  x1, y1, x2, y2 = [$1, $2, $3, $4].map(&:to_i)
  y1, y2 = y2, y1 if y1 > y2
  x1, x2 = x2, x1 if x1 > x2

  if x1 == x2
    (y1..y2).each do |y|
      grid[y] ||= Hash.new { 0 }
      grid[y][x1] += 1
    end
  elsif y1 == y2
    grid[y1] ||= Hash.new { 0 }
    (x1..x2).each do |x|
      grid[y1][x] += 1
    end
  end
end

puts grid.values.map(&:values).flatten.count { |v| v > 1 }

# Part 2

grid = {}

input.each do |line|
  line =~ /(\d+),(\d+) -> (\d+),(\d+)/
  x1, y1, x2, y2 = [$1, $2, $3, $4].map(&:to_i)

  if x1 > x2
    x1, x2 = x2, x1
    y1, y2 = y2, y1
  end
  # X1 always <= to X2

  if x1 == x2
    y1, y2 = y2, y1 if y1 > y2
    (y1..y2).each do |y|
      grid[y] ||= Hash.new { 0 }
      grid[y][x1] += 1
    end
  elsif y1 == y2
    grid[y1] ||= Hash.new { 0 }
    (x1..x2).each do |x|
      grid[y1][x] += 1
    end
  else
    dy = y1 < y2 ? 1 : -1
    (x2 - x1 + 1).times do |i|
      x = x1 + i
      y = y1 + (i * dy)
      grid[y] ||= Hash.new { 0 }
      grid[y][x] += 1
    end
  end
end

puts grid.values.map(&:values).flatten.count { |v| v > 1 }
