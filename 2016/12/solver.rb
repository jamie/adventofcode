require "advent"
input = Advent.input

require "assembunny"

# Part 1
cpu = Assembunny.new(input)
cpu.run
puts cpu.registers["a"]

# Part 2
cpu = Assembunny.new(input)
cpu.set_register("c", 1)
cpu.run
puts cpu.registers["a"]
