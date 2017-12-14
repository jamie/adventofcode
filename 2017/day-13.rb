input = File.readlines('input/13')

cycle_scanners = input.map do |line|
  line =~ /(\d+): (\d+)/
  [$1.to_i, $2.to_i, (($2.to_i) - 1)*2]
end.sort_by(&:last)

# Part 1
severities = cycle_scanners.map{|depth, range, loop_size|
  if depth % loop_size == 0
    depth * range
  else
    0
  end
}
puts severities.inject(&:+)

# Part 2
inf = 5_000_000
(0..inf).each do |delay|
  next if cycle_scanners.any?{|depth, _range, loop_size|
    (delay+depth) % loop_size == 0
  }
  puts delay
  break
end
