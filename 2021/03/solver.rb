require "advent"
input = Advent.input

xinput = <<~STR.split("\n")
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

gamma = input
  .map { |line| line.split("") }
  .transpose
  .map do |bit_n|
    zeroes = bit_n.select { |b| b == "0" }
    ones = bit_n.select { |b| b == "1" }

    zeroes.size > ones.size ? 0 : 1
  end
  .join
  .to_i(2)
epsilon = input
  .map { |line| line.split("") }
  .transpose
  .map do |bit_n|
    zeroes = bit_n.select { |b| b == "0" }
    ones = bit_n.select { |b| b == "1" }

    zeroes.size > ones.size ? 1 : 0
  end
  .join
  .to_i(2)

puts gamma * epsilon

# Part 2

bit_groups = input.map { |line| line.split("") }
bit_groups.first.size.times do |i|
  break if bit_groups.size == 1
  zeroes, ones = bit_groups.partition { |bits| bits[i] == "0" }.map(&:count)
  keep = (ones >= zeroes ? "1" : "0")
  bit_groups.select! { |bits| bits[i] == keep }
end
o2 = bit_groups.first.join.to_i(2)

bit_groups = input.map { |line| line.split("") }
bit_groups.first.size.times do |i|
  break if bit_groups.size == 1
  zeroes, ones = bit_groups.partition { |bits| bits[i] == "0" }.map(&:count)
  keep = (zeroes <= ones ? "0" : "1")
  bit_groups.select! { |bits| bits[i] == keep }
end
co2 = bit_groups.first.join.to_i(2)

puts o2 * co2
