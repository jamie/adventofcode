require 'advent'
input = Advent.input(2018, 19)

require 'device_cpu'

program = input[1..-1].map{|line|
  op, a, b, c = line.split(" ")
  [op, a.to_i, b.to_i, c.to_i]
}

# Part 1
cpu = CPU.new([0, 0, 0, 0, 0, 0])
cpu.bind(input[0].split(' ').last.to_i)
opcode = program[cpu.ip]
while opcode
  cpu.run(opcode)
  opcode = program[cpu.ip]
end
puts cpu.registers[0]

# Part 2, Brute-force is slow

# cpu = CPU.new([1, 0, 0, 0, 0, 0])
# cpu.bind(input[0].split(' ').last.to_i)
# i = 0
# while (opcode = program[cpu.ip])
#   prior0 = cpu.registers[0]
#   cpu.run(opcode)
#   i += 1
#   p [i, cpu.registers] if prior0 != cpu.registers[0]
# end
# puts cpu.registers[0]

# Inspecting registers each time register 0 changes,
# the first 4 lines of output are:
[0, 10551267, 0, 0, 10550400, 34]
[1, 10551267, 10551267, 1, 1, 7]
[4, 10551267, 3517089, 3, 1, 7]
[13, 10551267, 1172363, 9, 1, 7]
# register 1 contains a large number
# registers 2 and 3 multiply to that number
# register 0 increments by register 3.
# Assuming this pattern continues, the next value is going
# to be, um, 383. Iterating over all 10m values is bad.
# So off to Wolfram Alpha for the answer.
# https://www.wolframalpha.com/input/?i=sum+of+(divisors+of+10551267)
puts 15285504

# NB: I kinda hate meta-problems like this, where the problem is
#     discerning an execution pattern, without which the problem
#     will take a month to execute.
