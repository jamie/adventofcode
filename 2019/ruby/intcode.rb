class Intcode
  attr_reader :ip, :memory, :halted, :memory, :input, :output

  def initialize(prog)
    @memory_base = prog.split(",").map(&:to_i)
    @memory = @memory_base.dup
  end

  def reset
    @memory = @memory_base.dup
    @ip = 0
    @halted = false
    @input = []
    @output = []
    @input_ptr = 0
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
                write(memory[ip + 3], val1 + val2); 4
              when 2 # mul
                write(memory[ip + 3], val1 * val2); 4
              when 3 # input
                write(memory[ip + 1], next_input); 2
              when 4 # output
                @output << val1
                @ip += 2
                break
              when 5 # jump if nonzero
                jump(val2, val1 != 0, 3)
              when 6 # jump if zero
                jump(val2, val1 == 0, 3)
              when 7 # less than
                write(memory[ip + 3], val1 < val2 ? 1 : 0); 4
              when 8 # equals
                write(memory[ip + 3], val1 == val2 ? 1 : 0); 4
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

  def next_input
    input[@input_ptr].tap do |val|
      @input_ptr += 1
    end
  end

  def write(index, value)
    memory[index] = value
  end

  def jump(dest, cond, words)
    @ip = dest - words if cond
    words
  end
end
