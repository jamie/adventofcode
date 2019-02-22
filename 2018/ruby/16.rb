require "advent"
input = Advent.input(2018, 16)

require "device_cpu"

# Part 1: Test Cases
# NB: destructive use of input
samples = []
while input[0] != ""
  before = input.shift.split(": ")[1].gsub(/[\[,\]]/, "").split(" ").map(&:to_i)
  opcode = input.shift.split(" ").map(&:to_i)
  after = input.shift.split(": ")[1].gsub(/[\[,\]]/, "").split(" ").map(&:to_i)
  _blank = input.shift
  samples << [opcode, before, after]
end

OPNAMES = %w(
  addr addi mulr muli banr bani borr bori
  setr seti gtir gtri gtrr eqir eqri eqrr
)

vague = 0
samples.sort.uniq.each do |opcode, before, after|
  opcode = opcode.dup
  matches = OPNAMES.select { |opname|
    opcode[0] = opname
    actual = CPU.new(before).run(opcode).registers
    after == actual
  }.size
  vague += 1 if matches >= 3
end
puts vague

# Part 2: Test Program

# First, disambiguate operations
opcode_map = []
samples.sort.uniq.each do |opcode, before, after|
  opcode = opcode.dup
  opnum = opcode[0]
  matches = OPNAMES.select { |opname|
    opcode[0] = opname
    actual = CPU.new(before).run(opcode).registers
    after == actual
  }
  opcode_map[opnum] ||= OPNAMES
  opcode_map[opnum] &= matches
end

while opcode_map.detect { |e| e.kind_of? Array }
  opcode_map.each.with_index do |matching, opnum|
    if matching.size == 1
      opcode_map[opnum] = matching[0]
      opcode_map.each do |arr|
        next unless arr.kind_of? Array
        arr.delete(matching[0])
      end
    end
  end
end

# Then execute prog
cpu = CPU.new([0, 0, 0, 0])
input.shift
input.shift
while input[0] != nil
  opcode = input.shift.split(" ").map(&:to_i)
  opcode[0] = opcode_map[opcode[0]]
  cpu.run(opcode)
end
p cpu.registers[0]
