class Program
  attr_accessor :registers, :input, :index, :other, :queue, :send_count, :output

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

  def run
    step while !halted?
  end

  def step
    statement = input[index]
    self.index += 1

    case statement
    when /snd (.)/     ; snd($1)
    when /set (.) (.+)/; set($1, $2)
    when /add (.) (.+)/; add($1, $2)
    when /mul (.) (.+)/; mul($1, $2)
    when /mod (.) (.+)/; mod($1, $2)
    when /rcv (.)/     ; rcv($1)
    when /jgz (.) (.+)/; jgz($1, $2)
    else
      puts "Unknown instruction: #{input[index]}"
      exit
    end
  end

private
  def value(val, registers)
    (val =~ /[0-9]/ ? val.to_i : registers[val])
  end


  def set(reg, val)
    registers[reg] = value(val, registers)
  end

  def add(reg, val)
    registers[reg] += value(val, registers)
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

  def snd(val)
    self.output = registers[val]
  end

  def rcv(val)
    if value(val, registers) != 0
      self.index = -1
    end
  end
end
