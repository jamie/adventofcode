require "advent"
input = Advent.input

# Part 1

def safe?(values)
  diffs = values.count.pred.times.map do |i|
    values[i] - values[i+1]
  end
  diffs.all? { |n| (1..3).include?(n) } || diffs.all? { |n| (-3..-1).include?(n) }
end

safe = input.map do |line|
  values = line.scan(/[0-9]+/).map(&:to_i)
  safe?(values)
end
puts safe.count(true)

# Part 2

safe = input.map do |line|
  values = line.scan(/[0-9]+/).map(&:to_i)
  values.combination(values.size - 1).any? do |subset|
    safe?(subset)
  end
end
puts safe.count(true)
