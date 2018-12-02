require 'advent'
input = Advent.input(2017, 6)[0]
memory = input.split(/\s+/).map(&:to_i)

seen = {}
loop do
  break if seen[memory]
  seen[memory] = seen.size

  i = memory.each_with_index.detect{|e,k| e == memory.max}[1]
  val, memory[i] = memory[i], 0

  val.times { |j| memory[(i+1 + j) % memory.size] += 1}
end

puts seen.size
puts seen.size-seen[memory]
