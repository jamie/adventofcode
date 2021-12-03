require "advent"
input = Advent.input

ixnput = <<STR.split("\n")
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
STR

# Part 1

gamma = input.map{ |line| line.split(//)}.transpose.map do |bit_n|
  zeroes = bit_n.select{|b| b == '0'}
  ones = bit_n.select{|b| b == '1'}

  zeroes.size > ones.size ? 0 : 1
end
epsilon = input.map{ |line| line.split(//)}.transpose.map do |bit_n|
  zeroes = bit_n.select{|b| b == '0'}
  ones = bit_n.select{|b| b == '1'}

  zeroes.size > ones.size ? 1 : 0
end

puts gamma.join.to_i(2) * epsilon.join.to_i(2)

# Part 2

bit_groups = input.map{ |line| line.split(//)}
i = 0
while bit_groups.size > 1
  zeroes = bit_groups.select{|bits| bits[i] == '0'}
  ones = bit_groups.select{|bits| bits[i] == '1'}

  zeroes.size > ones.size ?
    bit_groups.reject!{|bits| bits[i] == '1'} :
    bit_groups.reject!{|bits| bits[i] == '0'}

  i += 1
end
oxygen = bit_groups.first.join.to_i(2)

bit_groups = input.map{ |line| line.split(//)}
i = 0
while bit_groups.size > 1
  zeroes = bit_groups.count{|bits| bits[i] == '0'}
  ones = bit_groups.count{|bits| bits[i] == '1'}

  zeroes <= ones ?
    bit_groups.reject!{|bits| bits[i] == '1'} :
    bit_groups.reject!{|bits| bits[i] == '0'}

  i += 1
end
scrubber = bit_groups.first.join.to_i(2)

puts oxygen * scrubber
