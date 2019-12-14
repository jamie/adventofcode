require "advent"
input = Advent.input

registers = Hash.new { 0 }
all_values = []

input.each do |instruction|
  fail instruction unless instruction =~ /(.+) (inc|dec) (-?\d+) if (.+) (<|>|<=|>=|==|!=) (-?\d+)/
  reg, op, val, cond_reg, cond, cond_val = Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3).to_i, Regexp.last_match(4), Regexp.last_match(5), Regexp.last_match(6).to_i

  # Thanks, AoC, for choosing operators that match Ruby semantics
  if registers[cond_reg].send(cond, cond_val)
    val *= -1 if op == "dec"
    registers[reg] += val
    all_values << registers[reg]
  end
end
puts registers.values.max
puts all_values.max
