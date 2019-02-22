require "advent"
input = Advent.input(2015, 9)

# Part 1
map = Hash.new { |h, k| h[k] = {} }

input.each do |line|
  line =~ /(.*) to (.*) = (.*)/
  map[$1][$2] = $3.to_i
  map[$2][$1] = $3.to_i
end

cities = map.keys
length = cities.permutation.to_a.map { |path|
  dist = 0
  (path.length - 1).times do |i|
    dist += map[path[i]][path[i + 1]]
  end
  dist
}.min
puts length

# Part 2
map = Hash.new { |h, k| h[k] = {} }

input.each do |line|
  line =~ /(.*) to (.*) = (.*)/
  map[$1][$2] = $3.to_i
  map[$2][$1] = $3.to_i
end

cities = map.keys
length = cities.permutation.to_a.map { |path|
  dist = 0
  (path.length - 1).times do |i|
    dist += map[path[i]][path[i + 1]]
  end
  dist
}.max
puts length
