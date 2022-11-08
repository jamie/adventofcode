require "advent"
input = Advent.input

c2 = 0
c3 = 0
input.each do |code|
  line = code.split("").sort.join
  fours = line.scan(/(.)\1\1\1/).flatten
  threes = line.scan(/(.)\1\1/).flatten
  twos = line.scan(/(.)\1/).flatten
  twos -= threes
  threes -= fours
  c3 += 1 if threes.any?
  c2 += 1 if twos.any?
end
puts c2 * c3

input.product(input).each do |a, b|
  next if a == b
  a_c = a.split("")
  b_c = b.split("")
  match = a_c.zip(b_c).select { |i, j| i == j }
  if match.size == a.size - 1
    puts match.map(&:first).join
    exit
  end
end
