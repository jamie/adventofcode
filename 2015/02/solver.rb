require "advent"
input = Advent.input()

# Part 1
total_area = 0

input.each do |line|
  x, y, z = line.chomp.split("x").map(&:to_i)

  sides = [x * y, y * z, z * x, x * y, y * z, z * x]
  area = sides.min + sides.inject(&:+)
  total_area += area
end

puts total_area

# Part 2
total_ribbon = 0

input.each do |line|
  x, y, z = line.chomp.split("x").map(&:to_i)

  total_ribbon += [x, y, z].sort[0..1].inject(&:+) * 2
  total_ribbon += x * y * z # Bow
end

puts total_ribbon
