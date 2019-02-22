require "advent"
input = Advent.input(2016, 20)

# Part 1
blocks = input.map do |row|
  row.chomp.split("-").map(&:to_i)
end.sort

allowed = 0

loop do
  min, max = blocks.shift
  if min <= allowed
    allowed = max + 1 if max >= allowed
  else
    puts allowed
    break
  end
end

# Part 2
MAX = 4294967296

blocks = input.map do |row|
  row.chomp.split("-").map(&:to_i)
end.sort + [[MAX, MAX]]

allowed = 0

permit_count = 0

loop do
  min, max = blocks.shift
  if min > allowed
    permit_count += (min - allowed)
  end
  break if max == MAX
  allowed = max + 1 if max >= allowed
end

puts permit_count
