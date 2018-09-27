class Assembunny
  attr_accessor :prog, :output, :registers

  def initialize(prog)
    @prog = prog
    reset!
  end

  def reset!
    @output = []
    @registers = Hash.new(0)
  end

  def set_register(key, value)
    registers[key] = value
  end

  def run
    pc = 0
    while prog[pc]
      op = prog[pc]
      pc += 1
      case op
      when /cpy (.*) (.*)/
        src = $1
        dst = $2
        if src =~ /\d/
          src = src.to_i
        else
          src = registers[src]
        end
        registers[dst] = src
      when /inc (.*)/
        registers[$1] += 1
      when /dec (.*)/
        registers[$1] -= 1
      when /jnz (.*) (.*)/
        src = $1
        mov = $2.to_i
        if src =~ /\d/
          src = src.to_i
        else
          src = registers[src]
        end
        if src != 0
          pc += mov - 1
        end
      when /out (.*)/
        output << registers[$1]
        return if output.size > 10
      else
        puts "Unknown op: #{op}"
        exit
      end
    end
  end
end

prog = File.readlines('input')
cpu = Assembunny.new(prog)
10_000.times do |i|
  cpu.reset!
  cpu.set_register('a', i)
  cpu.run
  p [i, cpu.output]
  if cpu.output == [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
    puts i
    exit
  end
end
