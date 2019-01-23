require 'advent'
input = Advent.input(2016, 23)

require 'assembunny'

# Part 1
cpu = Assembunny.new(input)
cpu.registers['a'] = 7
cpu.run
puts cpu.registers['a']
