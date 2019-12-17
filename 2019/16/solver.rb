require "advent"
input = Advent.input.split(//).map(&:to_i)

# Part 1
signal = input

PATTERN = [0, 1, 0, -1].freeze

def pattern(i, len)
  pat = rep = PATTERN.map { |v| [v] * i }.flatten
  pat += rep while pat.size < len + 1
  pat[1...(len + 1)]
end

patterns = 1.upto(signal.size).map{ |i| pattern(i, signal.size) }

100.times do |c|
  signal = signal.map.with_index do |n, i|
    [signal, patterns[i]].transpose.map { |x, y| x * y }.inject(&:+).abs % 10
  end
end
puts signal[0...8].join

# # Part 2
# input = '03036732577212944063491565474664'.split(//).map(&:to_i)
# signal = input * 10_000

# patterns = 1.upto(signal.size).map{|i| pattern(i, signal.size)}

# 100.times do |c|
#   signal = signal.map.with_index do |n, i|
#     [signal, patterns[i]].transpose.map { |x, y| x * y }.inject(&:+).abs % 10
#   end
# end

# offset = input[0...7].join.map(&:to_i)
# puts signal[offset...(offset+8)].join
