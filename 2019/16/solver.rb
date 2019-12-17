require "advent"
input = Advent.input.split(//).map(&:to_i)

PATTERN = [0, 1, 0, -1].freeze

def stretch(i, len)
  pat = rep = PATTERN.map { |v| [v] * i }.flatten
  pat += rep while pat.size < len + 1
  pat[1...(len + 1)]
end

# Part 1

signal = input

patterns = 1.upto(signal.size).map { |i| stretch(i, signal.size) }

100.times do |c|
  signal = signal.map.with_index do |n, i|
    [signal, patterns[i]].transpose.map { |x, y| x * y }.inject(&:+).abs % 10
  end
end
puts signal[0...8].join

# Part 2

# Insight from Reddit, offset is over halfway through the puzzle
# so the transform matrix here is upper triangular:
# [ 1 1 1 ... ]
# [ 0 1 1 ... ]
# [ 0 0 1 ... ]
# [ 0 0 0 ... ] ...
# So it's just a sequence of simple adds and muls, from offset onward.

# My own insight was working a running total for speed. It's still slow tho.

offset = input[0...7].join.to_i

signal = input * 10_000
signal = signal[offset..-1] # the only relevant part

100.times do |c|
  sum = signal.inject(&:+)
  signal = signal.map do |v|
    (sum % 10).tap { sum -= v }
  end
end

puts signal[0...8].join
