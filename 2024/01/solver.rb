require "advent"
input = Advent.input

# Part 1

answer = input
  .map { _1.split(/ +/).map(&:to_i) }
  .transpose
  .map(&:sort)
  .transpose
  .map { _1[-1] - _1[0] }
  .map(&:abs)
  .sum
puts answer

# Part 2

firsts, seconds = input
  .map { _1.split(/ +/).map(&:to_i) }
  .transpose
scores = firsts.map do |needle|
  needle * seconds.count(needle)
end
puts scores.sum
