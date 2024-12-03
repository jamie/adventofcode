require "advent"
input = Advent.input.join

# Part 1

puts input
  .scan(/mul\((\d+),(\d+)\)/)
  .map { |a, b| a.to_i * b.to_i }
  .sum

# Part 2

puts input
  .gsub(/don't\(\).*?do\(\)/, "")
  .scan(/mul\((\d+),(\d+)\)/)
  .map { |a, b| a.to_i * b.to_i }
  .sum
