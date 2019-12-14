require "advent"
input = Advent.input()

require "assembunny"

# Part 1
cpu = Assembunny.new(input)
cpu.registers["a"] = 7
cpu.run
puts cpu.registers["a"]

# Part 2 - refactor input to multiply
# "Hot" lines found via @usage, manually analyzed.
input[2..9] = ["", "", "mul a b", "", "", "", "", ""]

cpu = Assembunny.new(input)
cpu.registers["a"] = 12
cpu.run
puts cpu.registers["a"]
