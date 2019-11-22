require "advent"
input = Advent.input(2018, 21)

require "device_cpu"

program = input[1..-1].map do |line|
  op, a, b, c = line.split(" ")
  [op, a.to_i, b.to_i, c.to_i]
end

# Annotated Input

# #ip 1                 # r = [0,0,0,0,0,0]
# 0: seti 123 0 5       # r[5] = 123
# loop do
# 1: bani 5 456 5       #   r[5] &= 456
# 2: eqri 5 72 5        #   if r[5] == 72
# 3: addr 5 1 1         #     break; end
# 4: seti 0 0 1         #   end

# 5: seti 0 9 5         # r[5] = 0
# 6: bori 5 65536 2     # r[2] = r[5] | 65536
# 7: seti 7571367 9 5   # r[5] = 7571367
# 8: bani 2 255 4       # r[4] = r[2] & 255
# 9: addr 5 4 5         # r[5] += r[4]

# 10: bani 5 16777215 5  # r[5] &= 16777215
# 11: muli 5 65899 5     # r[5] *= 65899
# 12: bani 5 16777215 5  # r[5] &= 16777215
# 13: gtir 256 2 4       # if 256 > r[2]; r[4] = 1
# 14: addr 4 1 1         # GOTO 28
# 15: addi 1 1 1         # else; GOTO 17; end
# 16: seti 27 1 1        # GOTO 28
# 17: seti 0 2 4         # r[4] = 0

# 18: addi 4 1 3         # r[3] = r[4] + 1
# 19: muli 3 256 3       # r[3] *= 256

# 20: gtrr 3 2 3         # if r[3] > r[2]; r[3] = 1
# 21: addr 3 1 1         # GOTO 26
# 22: addi 1 1 1         # else; GOTO 24; end
# 23: seti 25 6 1        # GOTO 26
# 24: addi 4 1 4         # r[4] += 1
# 25: seti 17 8 1        # GOTO 18
#
# 26: setr 4 6 2         # r[2] = r[4]
# 27: seti 7 4 1         # GOTO 8

# 28: eqrr 5 0 4
# 29: addr 4 1 1         # return if (r[5] == r[0])
# 30: seti 5 5 1         # else GOTO 6

# Part 1

cpu = CPU.new([0, 0, 0, 0, 0, 0])
cpu.bind(input[0].split(" ").last.to_i)

opcode = program[cpu.ip]
while opcode
  cpu.run(opcode)
  # By inspection, we check for halt on line 28, so grab the first
  # value checked, that's our shortest halting program
  if cpu.ip == 29
    puts cpu.registers[5]
    break
  end
  opcode = program[cpu.ip]
end

# Part 2

# Actually simulating the elfscript is too slow
# rewrite in ruby (based on the annotated code above)

r5 = 0
seen = []

while !seen.include?(r5) # 30
  seen << r5
  r2 = r5 | 65536 # 6
  r5 = 7571367    # 7
  r5 = (((r5 + (r2 & 255))) * 65899) & 0xffffff # 8-12, unrolled
  while 256 <= r2 # 13
    # r4 = 0 # 17
    # r3 = (r4 + 1) * 256 # 18-19, unrolled
    # while r3 <= r2  # 20-21
    #   r4 += 1 # 24
    #   r3 = (r4 + 1) * 256 # 18-19
    # end
    # r2 = r4   # 26
    r2 /= 256 # 17-26, using division

    r5 = (((r5 + (r2 & 255))) * 65899) & 0xffffff # 8-12
  end
  # exit if (r5 == r[0]) # 28-29
end
puts seen.last
