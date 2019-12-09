class Intcode
  attr_reader :ip, :memory, :halted, :memory, :input, :output

  def initialize(prog)
    @memory_base = prog.split(",").map(&:to_i)
    @memory = @memory_base.dup
    reset
  end

  def reset
    @memory = @memory_base.dup
    @ip = 0
    @halted = false
    @input = []
    @output = []
    @input_ptr = 0
    @relative_base = 0
    self
  end

  def peek(addr)
    memory[addr]
  end

  def poke(addr, value)
    memory[addr] = value
    self
  end

  def input!(buffer)
    @input = buffer
    self
  end

  def output!(buffer)
    @output = buffer
    self
  end

  def chain!(other, *others)
    output!(other.input)
    other.chain!(*others) if others.any?
  end

  def execute
    return if halted

    loop do
      @modes, opcode = memory[ip].divmod(100)
      words = case opcode
              when 1 # add
                write(3, val1 + val2); 4
              when 2 # mul
                write(3, val1 * val2); 4
              when 3 # input
                unless next_input?
                  # print 'waiting for input'
                  return
                end
                write(1, next_input); 2
              when 4 # output
                @output << val1; 2
              when 5 # jump if nonzero
                jump(val2, val1 != 0, 3)
              when 6 # jump if zero
                jump(val2, val1 == 0, 3)
              when 7 # less than
                write(3, val1 < val2 ? 1 : 0); 4
              when 8 # equals
                write(3, val1 == val2 ? 1 : 0); 4
              when 9 # relative
                @relative_base += val1; 2
              when 99 # halt
                @halted = true
                break
              else
                fail "Unknown opcode: #{memory[ip]}"
              end
      @ip += words
    end
    @output.last
  end

  private

  def val1
    i = ip + 1
    mode = @modes % 10
    val = memory[i] || 0
    val += @relative_base if mode == 2
    val = memory[val] || 0 unless mode == 1
    val
  end

  def val2
    i = ip + 2
    mode = @modes / 10 % 10
    i += @relative_base if mode == 2
    val = memory[i] || 0
    val = memory[val] || 0 unless mode == 1
    val
  end

  def next_input?
    input[@input_ptr]
  end

  def next_input
    input[@input_ptr].tap do |val|
      @input_ptr += 1
    end
  end

  def write(i, value)
    index = memory[ip + i]
    if i == 1
      mode = @modes % 10
    elsif i == 3
      mode = @modes / 100 % 10
    else
      fail 'Unknown arg offset for write'
    end
    index += @relative_base if mode == 2
    memory[index] = value
  end

  def jump(dest, cond, words)
    @ip = dest - words if cond
    words
  end
end
