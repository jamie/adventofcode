class Program
  attr_accessor :registers, :input, :index, :other, :queue, :send_count, :output

  def initialize(input, id = 0)
    self.input = input
    self.registers = Hash.new { 0 }
    registers["p"] = id
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

  def run
    step until halted?
  end

  def step
    statement = input[index]
    self.index += 1

    case statement
    when /snd (.)/ then snd(Regexp.last_match(1))
    when /set (.) (.+)/ then set(Regexp.last_match(1), Regexp.last_match(2))
    when /add (.) (.+)/ then add(Regexp.last_match(1), Regexp.last_match(2))
    when /sub (.) (.+)/ then sub(Regexp.last_match(1), Regexp.last_match(2))
    when /mul (.) (.+)/ then mul(Regexp.last_match(1), Regexp.last_match(2))
    when /mod (.) (.+)/ then mod(Regexp.last_match(1), Regexp.last_match(2))
    when /rcv (.)/ then rcv(Regexp.last_match(1))
    when /jgz (.) (.+)/ then jgz(Regexp.last_match(1), Regexp.last_match(2))
    when /jnz (.) (.+)/ then jnz(Regexp.last_match(1), Regexp.last_match(2))
    when nil then nil
    else
      puts "Unknown instruction: #{input[index].inspect}"
      exit
    end
  end

  private

  def value(val, registers)
    (/[0-9]/.match?(val) ? val.to_i : registers[val])
  end

  def set(reg, val)
    registers[reg] = value(val, registers)
  end

  def add(reg, val)
    registers[reg] += value(val, registers)
  end

  def sub(reg, val)
    registers[reg] -= value(val, registers)
  end

  def mul(reg, val)
    registers[reg] *= value(val, registers)
  end

  def mod(reg, val)
    registers[reg] %= value(val, registers)
  end

  def jgz(val, off)
    if value(val, registers) > 0
      self.index += value(off, registers) - 1
    end
  end

  def jnz(val, off)
    if value(val, registers) != 0
      self.index += value(off, registers) - 1
    end
  end

  def snd(val)
    self.output = registers[val]
  end

  def rcv(val)
    if value(val, registers) != 0
      self.index = -1
    end
  end
end
