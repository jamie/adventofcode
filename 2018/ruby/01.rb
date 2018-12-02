require 'advent'
input = Advent.input(2018, 1, :to_i)

# Part 1
puts input.inject(0) { |memo, e| memo + e }

# Part 2
freqs = {}
freq = 0

freqs[freq] = true

loop do
  i = input.shift
  freq += i.to_i
  break if freqs[freq]
  freqs[freq] = true
  input << i
end
puts freq
