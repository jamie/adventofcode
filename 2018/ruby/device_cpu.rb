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
        when "addr"; ra + rb
        when "addi"; ra + @b
        when "mulr"; ra * rb
        when "muli"; ra * @b
        when "banr"; ra & rb
        when "bani"; ra & @b
        when "borr"; ra | rb
        when "bori"; ra | @b
        when "setr"; ra
        when "seti"; @a
        when "gtir"; @a > rb ? 1 : 0
        when "gtri"; ra > @b ? 1 : 0
        when "gtrr"; ra > rb ? 1 : 0
        when "eqir"; @a == rb ? 1 : 0
        when "eqri"; ra == @b ? 1 : 0
        when "eqrr"; ra == rb ? 1 : 0
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
