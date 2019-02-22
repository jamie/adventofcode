require "advent"
input = Advent.input(2016, 6)

# Part 1
word = input.map { |line|
  line.split(//)
}.transpose.map { |place|
  place.group_by { |e| e }.sort_by { |k, v| v.size }.last.first
}

puts word.join

# Part 2
word = input.map { |line|
  line.split(//)
}.transpose.map { |place|
  place.group_by { |e| e }.sort_by { |k, v| v.size }.first.first
}

puts word.join
