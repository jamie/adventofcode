class Assembunny
  attr_accessor :prog, :output, :registers, :usage

  def initialize(prog)
    @prog = prog.map{|stmt| stmt.strip.split(' ')}
    reset!
  end

  def reset!
    @usage = [0] * @prog.size
    @output = []
    @registers = {
      'a' => 0,
      'b' => 0,
      'c' => 0,
      'd' => 0,
    }
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
      @usage[pc] += 1
      op, x, y = prog[pc]
      case op
      when 'inc'
        registers[x] += 1
      when 'dec'
        registers[x] -= 1
      when 'cpy'
        xval = registers[x] || x.to_i
        registers[y] = xval
      when 'jnz'
        xval = registers[x] || x.to_i
        yval = registers[y] || y.to_i
        pc += yval - 1 if xval != 0
      when 'mul'
        xval = registers[x] || x.to_i
        yval = registers[y] || y.to_i
        registers[x] = xval * yval
      when 'tgl'
        index = pc + registers[x]
        if prog[index]
          # puts "Toggle #{index} of #{prog.size}"
          inst = prog[index][0]
          case prog[index].size
          when 2
            prog[index][0] = (inst == "inc") ? "dec" : "inc"
          when 3
            prog[index][0] = (inst == "jnz") ? "cpy" : "jnz"
          end
        end
      when 'out'
        output << registers[x]
        return if output.size > 10
      when nil
        # skip empty lines
      else
        puts "Unknown op: #{op}"
        exit
      end
      pc += 1
    end
  end
end
