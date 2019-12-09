require "advent"
input = Advent.input(2019, 9)

require 'intcode'

input = '109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99'

intcode = Intcode.new(input).input!([1])
intcode.execute until intcode.halted
p intcode
p intcode.output
