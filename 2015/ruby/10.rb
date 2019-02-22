require "advent"
input = Advent.input(2015, 10)

phrase = input[0]
50.times do |i|
  groups = phrase.scan(/((.)\2*)/).map(&:first)
  phrase = groups.map { |group| [group.length, group[0]] }.flatten.join
  # Part 1
  puts phrase.length if i + 1 == 40
  # Part 2
  puts phrase.length if i + 1 == 50
end
