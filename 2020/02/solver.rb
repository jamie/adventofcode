require "advent"
input = Advent.input

# Part 1
valid = input.select do |line|
  count, letter, password = line.split(/:? /)
  min, max = count.split("-").map(&:to_i)
  matches = password.scan(/#{letter}/).size
  (min..max).include?(matches)
end
puts valid.size

# Part 2
valid = input.select do |line|
  count, letter, password = line.split(/:? /)
  min, max = count.split("-").map(&:to_i)
  a, b = password[min - 1], password[max - 1]
  (a == letter || b == letter) && a != b
end
puts valid.size
