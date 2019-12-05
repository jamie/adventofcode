class Intcode
  attr_reader :ip, :memory

  def initialize(prog)
    @memory_base = prog.split(",").map(&:to_i)
    @memory = @memory_base.dup
  end

  def reset(noun=nil, verb=nil)
    @memory = @memory_base.dup
    memory[1] = noun if noun
    memory[2] = verb if verb
    self
  end

  def execute(data=[])
    @data = data.dup

    @ip = 0
    loop do
      @modes, opcode = memory[ip].divmod(100)
      words = case opcode
              when 1 # add
                write(memory[ip + 3], val1 + val2); 4
              when 2 # mul
                write(memory[ip + 3], val1 * val2); 4
              when 3 # input
                write(memory[ip + 1], @data.shift); 2
              when 4 # output
                puts val1; 2
              when 5 # jump if nonzero
                jump(val2, val1 != 0, 3)
              when 6 # jump if zero
                jump(val2, val1 == 0, 3)
              when 7 # less than
                write(memory[ip + 3], val1 < val2 ? 1 : 0); 4
              when 8 # equals
                write(memory[ip + 3], val1 == val2 ? 1 : 0); 4
              when 99 # halt
                break
              else
                puts "Unknown opcode: #{memory[ip]}"
                break
              end
      @ip += words
    end
    memory[0]
  end

  private

  def val1
    i = ip + 1
    val = memory[i]
    val = memory[val] unless memory[ip].to_s.reverse[2] == '1'
    val
  end

  def val2
    i = ip + 2
    val = memory[i]
    val = memory[val] unless memory[ip].to_s.reverse[3] == '1'
    val
  end

  def write(index, value)
    memory[index] = value
  end

  def jump(dest, cond, words)
    @ip = dest - words if cond
    words
  end
end
