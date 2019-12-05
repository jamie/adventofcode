require "advent"
input = Advent.input(2019, 5)

require 'intcode'

intcode = Intcode.new(input)

intcode.reset.execute([1])
intcode.reset.execute([5])
