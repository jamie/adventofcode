require "advent"
input = Advent.input

digits = input.split(',').map(&:to_i)

seen = {}
digits.each.with_index do |d, i|
  seen[d] = [i]
end

i = digits.size
prior = digits.last
loop do
  digit = if seen[prior].size == 1
    0
  else
    seen[prior][-1] - seen[prior][-2]
  end
  seen[digit] ||= []
  seen[digit] << i

  i += 1
  prior = digit
  puts prior if i == 2020 # Part 1
  break if i == 30000000 # Part 2
end
puts prior
