require "advent"
input = Advent.input.split(//).map(&:to_i)

inxput = "80871224585914546619083218645595".split(//).map(&:to_i)

signal = input

PATTERN = [0, 1, 0, -1]

def pattern(i, len)
  pat = rep = PATTERN.map { |v| [v] * (i) }.flatten
  pat += rep while pat.size - 1 < len
  pat[1..len]
end

100.times do |c|
  signal = signal.map.with_index do |n, i|
    pat = pattern(i + 1, signal.size)

    [signal, pat].transpose.map { |x, y| x * y }.inject(&:+).abs % 10
  end
end
puts signal[0...8].join
