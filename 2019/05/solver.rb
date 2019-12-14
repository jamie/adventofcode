require "advent"
input = Advent.input

require "intcode"

intcode = Intcode.new(input)

intcode.reset
out = intcode.input!([1]).execute
out = intcode.execute while out == 0
puts out

puts intcode.reset.input!([5]).execute
