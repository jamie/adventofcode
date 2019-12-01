require "advent"
input = Advent.input(2016, 6)

# Part 1
word = input.map do |line|
  line.split(//)
end.transpose.map do |place|
  place.group_by { |e| e }.sort_by { |k, v| v.size }.last.first
end

puts word.join

# Part 2
word = input.map do |line|
  line.split(//)
end.transpose.map do |place|
  place.group_by { |e| e }.sort_by { |k, v| v.size }.first.first
end

puts word.join
