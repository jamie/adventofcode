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
        p [pc, registers]
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
      when /tgl (.*)/
        index = registers[$1] + pc
        next if prog[index].nil?
        puts "Toggle #{index+pc} of #{prog.size}"
        prog[index] = case prog[index]
        when /(.*) (.*) (.*)/
          "#{($1 == "jnz") ? "cpy" : "jnz"} #{$2} #{$3}"
        when /(.*) (.*)/
          "#{($1 == "inc") ? "dec" : "inc"} #{$2}"
        end
        require 'pp'
        pp prog
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
cpu.registers['a'] = 7
cpu.run
puts cpu.registers['a']