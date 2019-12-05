require "advent"
input = Advent.input(2019, 5)

class Intcode
  attr_reader :ip, :memory

  def initialize(prog)
    @memory_base = prog.split(",").map(&:to_i)
  end

  def reset(noun, verb)
    @memory = @memory_base.dup
    memory[1] = noun
    memory[2] = verb
  end

  def execute(input)
    @memory = @memory_base.dup
    @input = input.dup

    @ip = 0
    loop do
      @modes, opcode = memory[ip].divmod(100)
      # p [[ip], memory[ip]]
      case opcode
      when 1
        add
      when 2
        mul
      when 3
        read
      when 4
        write
      when 5
        jump_nonzero
      when 6
        jump_zero
      when 7
        less_than
      when 8
        equals
      when 99 # halt
        break
      else
        puts "Unknown opcode: #{memory[ip]}"
        break
      end
    end
    memory[0]
  end

  private

  def args(count)
    modes = @modes
    1.upto(count).map do |i|
      modes, mode = modes.divmod(10)
      if mode == 0
        # p [i, :pointer, memory[ip + i]]
        memory[memory[ip + i]]
      else
        # p [i, :immediate]
        memory[ip + i]
      end
    end
  end

  def add
    val1, val2 = args(2)
    # p [:add, val1, val2, '->', memory[ip+3] ]
    i = memory[ip+3]

    memory[i] = val1 + val2
    @ip += 4
  end

  def mul
    val1, val2 = args(2)
    # p [:mul, val1, val2, '->', ip+3]

    i = memory[ip+3]
    memory[i] = val1 * val2
    @ip += 4
  end

  def read
    # p [:read, ip+1, @input[0]]

    i = memory[ip + 1]
    memory[i] = @input.shift
    @ip += 2
  end

  def write
    val1 = args(1)[0]

    puts val1
    @ip += 2
  end

  def jump_nonzero
    val1, val2 = args(2)
    if val1 != 0
      @ip = val2
    else
      @ip += 3
    end
  end

  def jump_zero
    val1, val2 = args(2)
    if val1 == 0
      @ip = val2
    else
      @ip += 3
    end
  end

  def less_than
    val1, val2 = args(2)
    i = memory[ip+3]
    memory[i] = (val1 < val2) ? 1 : 0
    @ip += 4
  end

  def equals
    val1, val2 = args(2)
    i = memory[ip+3]
    memory[i] = (val1 == val2) ? 1 : 0
    @ip += 4
  end
end

Intcode.new(input).execute([1])
Intcode.new(input).execute([5])
