require 'advent'
input = Advent.input(2017, 18)

require 'bytecode-interpreter'

prog = Program.new(input)
prog.run
puts prog.output

# Part 2, redefine some opcodes
class Program
private
  def snd(reg)
    self.send_count += 1
    other.receive registers[reg]
  end

  def rcv(reg)
    if queue.empty?
      self.index -= 1
    else
      registers[reg] = queue.shift
    end
  end
end

p0 = Program.new(input, 0)
p1 = Program.new(input, 1)
p0.other = p1
p1.other = p0

loop do
  break if p0.waiting? && p1.waiting?
  break if p0.halted? || p1.halted?

  p0.step
  p1.step
end
puts p1.send_count

