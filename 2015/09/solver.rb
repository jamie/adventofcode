require "advent"
input = Advent.input(2015, 9)

# Part 1
map = Hash.new { |h, k| h[k] = {} }

input.each do |line|
  line =~ /(.*) to (.*) = (.*)/
  map[Regexp.last_match(1)][Regexp.last_match(2)] = Regexp.last_match(3).to_i
  map[Regexp.last_match(2)][Regexp.last_match(1)] = Regexp.last_match(3).to_i
end

cities = map.keys
length = cities.permutation.to_a.map do |path|
  dist = 0
  (path.length - 1).times do |i|
    dist += map[path[i]][path[i + 1]]
  end
  dist
end.min
puts length

# Part 2
map = Hash.new { |h, k| h[k] = {} }

input.each do |line|
  line =~ /(.*) to (.*) = (.*)/
  map[Regexp.last_match(1)][Regexp.last_match(2)] = Regexp.last_match(3).to_i
  map[Regexp.last_match(2)][Regexp.last_match(1)] = Regexp.last_match(3).to_i
end

cities = map.keys
length = cities.permutation.to_a.map do |path|
  dist = 0
  (path.length - 1).times do |i|
    dist += map[path[i]][path[i + 1]]
  end
  dist
end.max
puts length
