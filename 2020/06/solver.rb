require "advent"
input = Advent.input
  .join("\n")
  .split("\n\n")
  .map { |batch| batch.split("\n") }

# Part 1
puts(input.sum do |lines|
  lines.join.split("").sort.uniq.size
end)

# Part 2
puts(input.sum do |lines|
  lines
    .map { |line| line.split("") }
    .inject { |a, b| a & b }
    .size
end)
