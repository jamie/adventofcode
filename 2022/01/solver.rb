require "advent"
input = Advent.input
  .join("\n")
  .split("\n\n")
  .map { _1.split("\n").map(&:to_i) }

# Part 1

puts input.map(&:sum).max

# Part 2

puts input.map(&:sum).sort[-3..-1].sum
