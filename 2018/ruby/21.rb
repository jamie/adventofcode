require 'advent'
input = Advent.input(2018, 21)

require 'device_cpu'

program = input[1..-1].map{|line|
  op, a, b, c = line.split(" ")
  [op, a.to_i, b.to_i, c.to_i]
}

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

#10: bani 5 16777215 5  # r[5] &= 16777215
#11: muli 5 65899 5     # r[5] *= 65899
#12: bani 5 16777215 5  # r[5] &= 16777215
#13: gtir 256 2 4       # if 256 > r[2]; r[4] = 1
#14: addr 4 1 1         # GOTO 28
#15: addi 1 1 1         # else; GOTO 17; end
#16: seti 27 1 1        # GOTO 28
#17: seti 0 2 4         # r[4] = 0

#18: addi 4 1 3         # r[3] = r[4] + 1
#19: muli 3 256 3       # r[3] *= 256

#20: gtrr 3 2 3         # if r[3] > r[2]; r[3] = 1
#21: addr 3 1 1         # GOTO 26
#22: addi 1 1 1         # else; GOTO 24; end
#23: seti 25 6 1        # GOTO 26
#24: addi 4 1 4         # r[4] += 1
#25: seti 17 8 1        # GOTO 18
                        #
#26: setr 4 6 2         # r[2] = r[4]
#27: seti 7 4 1         # GOTO 8


#28: eqrr 5 0 4
#29: addr 4 1 1         # return if (r[5] == r[0])
#30: seti 5 5 1         # else GOTO 6


# Part 1

cpu = CPU.new([0, 0, 0, 0, 0, 0])
cpu.bind(input[0].split(' ').last.to_i)
while (opcode = program[cpu.ip])
  cpu.run(opcode)
  # By inspection, we check for halt on line 28, so grab the first
  # value checked, that's our shortest halting program
  if cpu.ip == 29
    puts cpu.registers[5]
    break
  end
end

# Part 2

# Actually simulating the elfscript is too slow
# rewrite in ruby (based on the annotated code above)

def run(r, seen)
  r[2] = r[5] | 65536 # 6
  r[5] = 7571367      # 7
  loop do
    r[4] = r[2] & 255 # 8
    r[5] += r[4]      # 9
    r[5] &= 16777215  # 10
    r[5] *= 65899     # 11
    r[5] &= 16777215  # 12
    if 256 > r[2]     # 13
      exit if (r[5] == r[0]) # 28-29
      if seen.include?(r[5])
        puts seen.last
        exit
      end
      seen << r[5]
      return          # 30
    end

    r[4] = 0 # 17
    loop do
      r[3] = r[4] + 1 # 18
      r[3] *= 256     # 19
      if r[3] > r[2]  # 20-21
        r[2] = r[4]   # 26
        break
      end
      r[4] += 1 # 24
    end
  end
end

r = [0,0,0,0,0,0]
seen = []

# Sanity check
r[5] = 123
loop do
  r[5] &= 456
  if r[5] == 72
    break
  end
end
r[5] = 0

loop do
  run(r, seen)
end
