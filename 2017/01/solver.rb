require "advent"
input = Advent.input().split(//).map(&:to_i)

puts input.select.with_index { |val, index|
  input[(index + 1) % input.size] == val
}.inject(&:+)

puts input.select.with_index { |val, index|
  input[(index + input.size / 2) % input.size] == val
}.inject(&:+)
