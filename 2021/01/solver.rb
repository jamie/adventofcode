require "advent"
input = Advent.input

xinput = <<~STR.split("\n")
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
STR

input.map!(&:to_i)

# Part 1

ups = 0
last = input.first
input.each do |x|
  ups += 1 if x > last
  last = x
end
puts ups

# Part 2

ups = 0
(input.size - 2).times do |i|
  x = input[i..(i + 2)].sum
  ups += 1 if x > last
  last = x
end
puts ups
