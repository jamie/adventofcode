input = File.readlines('input/18')


class Program
  attr_accessor :registers, :input, :index, :other, :queue, :send_count

  def initialize(input, id)
    self.input = input
    self.registers = Hash.new{0}
    registers['p'] = id
    self.index = 0
    self.queue = []
    self.send_count = 0
  end

  def receive(msg)
    queue << msg
  end

  def waiting?
    queue.empty? && input[index] =~ /rcv/
  end

  def halted?
    index < 0 || index > input.size
  end

  def step
    statement = input[index]
    self.index += 1

    case statement
    when /snd (.)/
      val = $1
      self.send_count += 1
      other.receive registers[val]
    
    when /set (.) (.+)/
      reg, val = $1, $2
      registers[reg] = value(val, registers)

    when /add (.) (.+)/
      reg, val = $1, $2
      registers[reg] += value(val, registers)
    
    when /mul (.) (.+)/
      reg, val = $1, $2
      registers[reg] *= value(val, registers)
    
    when /mod (.) (.+)/
      reg, val = $1, $2
      registers[reg] %= value(val, registers)
    
    when /rcv (.)/
      if queue.empty?
        self.index -= 1
      else
        registers[$1] = queue.shift
      end
    
    when /jgz (.) (.+)/
      val, off = $1, $2
      if value(val, registers) > 0
        self.index += value(off, registers) - 1
      end
    
    else
      puts "Unknown instruction: #{input[index]}"
      exit
    end
  end

private
  def value(val, registers)
    (val =~ /[0-9]/ ? val.to_i : registers[val])
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