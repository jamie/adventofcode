input = File.readlines('input/23')

require './bytecode-interpreter'

class MulCountingProgram < Program
  attr_reader :mul_count

  def initialize(*)
    super
    @mul_count = 0
  end

  def mul(reg, val)
    @mul_count += 1
    registers[reg] *= value(val, registers)
  end
end

prog = MulCountingProgram.new(input)
prog.run
puts prog.mul_count

# part 2
prog = Program.new(input)
prog.registers['a'] = 1
prog.run
puts prog.registers['h']
