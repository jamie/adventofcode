require "advent"
input = Advent.input.map(&:to_i)

# Part 1

invalid = nil
(25..input.size).each do |i|
  valid = false
  prior = input[(i - 25)..(i - 1)]
  prior.each_with_index do |x, xi|
    prior[(xi + 1)..-1].each do |y|
      valid = true if input[i] == x + y
    end
  end
  invalid ||= input[i] unless valid
end
puts invalid

# Part 2

key = nil
input.size.times do |i|
  (i..(input.size - 1)).each do |j|
    range = input[i..j]
    key ||= range if range.sum == invalid
  end
end
puts key.min + key.max
