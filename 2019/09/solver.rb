require "advent"
input = Advent.input(2019, 9)

require "intcode"

intcode = Intcode.new(input).input!([1])
intcode.execute until intcode.halted
p intcode.output[0]

intcode = Intcode.new(input).input!([2])
intcode.execute until intcode.halted
p intcode.output[0]
