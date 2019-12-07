require "advent"
input = Advent.input(2019, 5)

require 'intcode'

intcode = Intcode.new(input)

intcode.reset
out = intcode.execute([1])
out = intcode.execute while out == 0
puts out

puts intcode.reset.execute([5])
