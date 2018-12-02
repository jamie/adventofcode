require 'advent'
input = Advent.input(2017, 8)

registers = Hash.new{0}
all_values = []

input.each do |instruction|
  fail instruction unless instruction =~ /(.+) (inc|dec) (-?\d+) if (.+) (<|>|<=|>=|==|!=) (-?\d+)/
  reg, op, val, cond_reg, cond, cond_val = $1, $2, $3.to_i, $4, $5, $6.to_i

  # Thanks, AoC, for choosing operators that match Ruby semantics
  if registers[cond_reg].send(cond, cond_val)
    val *= -1 if op == 'dec'
    registers[reg] += val
    all_values << registers[reg]
  end
end
puts registers.values.max
puts all_values.max