require "advent"
input = Advent.input(2015, 17, :to_i)

# Part 1
containers = input.sort.reverse

total = 0
(1..containers.size).each do |count|
  containers.combination(count).to_a.each do |combination|
    total += 1 if combination.inject(&:+) == 150
  end
end
puts total

# Part 2
containers = input.sort.reverse

total = 0
(1..containers.size).each do |count|
  containers.combination(count).to_a.each do |combination|
    total += 1 if combination.inject(&:+) == 150
  end
  break if total > 0
end
puts total
