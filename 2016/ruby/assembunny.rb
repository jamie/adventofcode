class Assembunny
  attr_accessor :prog, :output, :registers

  def initialize(prog)
    @prog = prog.map{|stmt| stmt.split(' ')}
    reset!
  end

  def reset!
    @output = []
    @registers = Hash.new(0)
  end

  def set_register(key, value)
    registers[key] = value
  end

  def val(x)
    if x =~ /\d/
      x.to_i
    else
      registers[x]
    end
  end

  def run
    pc = 0
    while prog[pc]
      op, x, y = prog[pc]
      pc += 1
      case op
      when 'inc'
        registers[x] += 1
      when 'dec'
        registers[x] -= 1
      when 'cpy'
        xval = if x =~ /\d/
          x.to_i
        else
          registers[x]
        end
        registers[y] = xval
      when 'jnz'
        xval = if x =~ /\d/
          x.to_i
        else
          registers[x]
        end
        pc += y.to_i - 1 if xval != 0
      when 'tgl'
        index = registers[x] + pc
        next if prog[index].nil?
        puts "Toggle #{index+pc} of #{prog.size}"
        inst = prog[index][0]
        case prog[index]
        when 3
          prog[index][0] = (inst == "jnz") ? "cpy" : "jnz"
        when 2
          prog[index][0] = (inst == "inc") ? "dec" : "inc"
        end
        pp prog
      when 'out'
        output << registers[x]
        return if output.size > 10
      else
        puts "Unknown op: #{op}"
        exit
      end
    end
  end
end
