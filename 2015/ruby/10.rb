require 'advent'
input = Advent.input(2015, 10)

# Part 1
phrase = input[0]

50.times do |i|
  puts phrase.length if i == 40

  groups = phrase.scan(/((.)\2*)/).map(&:first)
  phrase = groups.map{|group| [group.length, group[0]] }.flatten.join
end

# Part 2
puts phrase.length