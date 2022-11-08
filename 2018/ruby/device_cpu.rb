class CPU
  attr_accessor :registers, :ip

  def initialize(registers)
    @registers = registers.dup
    @ip = 0
  end

  def bind(register)
    @ip_bind = register
  end

  def run(opcode)
    registers[@ip_bind] = @ip if @ip_bind

    op, @a, @b, @c = opcode

    set case op
    when "addr" then ra + rb
    when "addi" then ra + @b
    when "mulr" then ra * rb
    when "muli" then ra * @b
    when "banr" then ra & rb
    when "bani" then ra & @b
    when "borr" then ra | rb
    when "bori" then ra | @b
    when "setr" then ra
    when "seti" then @a
    when "gtir" then @a > rb ? 1 : 0
    when "gtri" then ra > @b ? 1 : 0
    when "gtrr" then ra > rb ? 1 : 0
    when "eqir" then @a == rb ? 1 : 0
    when "eqri" then ra == @b ? 1 : 0
    when "eqrr" then ra == rb ? 1 : 0
    else
      "nil"
    end

    @ip = registers[@ip_bind] if @ip_bind
    @ip += 1

    self
  end

  def set(value)
    registers[@c] = value
  end

  def ra
    registers[@a]
  end

  def rb
    registers[@b]
  end
end
