require "advent"
input = Advent.input

inxput = "16,1,2,0,4,2,7,1,2,14"
crabs = input.split(",").map(&:to_i)

# Part 1

cost = Float::INFINITY

(0..(crabs.max)).each do |n|
  fuel = crabs.map { |crab| (crab - n).abs }.sum
  cost = fuel if fuel < cost
end

puts cost

# Part 2

cost = Float::INFINITY

(0..(crabs.max)).each do |n|
  fuel = crabs.map { |crab|
    steps = (crab - n).abs
    (1..steps).sum
  }.sum
  cost = fuel if fuel < cost
end

puts cost
