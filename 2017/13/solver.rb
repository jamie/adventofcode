require "advent"
input = Advent.input

scanners = input.map do |line|
  line =~ /(\d+): (\d+)/
  [Regexp.last_match(1).to_i, Regexp.last_match(2).to_i, (Regexp.last_match(2).to_i - 1) * 2]
end.sort_by(&:last)

# Part 1
severities = scanners.map do |depth, range, loop_size|
  if depth % loop_size == 0
    depth * range
  else
    0
  end
end
puts severities.inject(&:+)

# Part 2
(0..50_000_000).each do |delay|
  next if scanners.any? do |depth, _range, loop_size|
    (delay + depth) % loop_size == 0
  end
  puts delay
  break
end
