require 'advent'
input = Advent.input(2016, 12)

# Part 1
prog = input.dup
registers = Hash.new(0)

pc = 0
while prog[pc]
  op = prog[pc]
  pc += 1
  case op
  when /cpy (.*) (.*)/
    src = $1
    dst = $2
    if src =~ /\d/
      src = src.to_i
    else
      src = registers[src]
    end
    registers[dst] = src
  when /inc (.*)/
    registers[$1] += 1
  when /dec (.*)/
    registers[$1] -= 1
  when /jnz (.*) (.*)/
    src = $1
    mov = $2.to_i
    if src =~ /\d/
      src = src.to_i
    else
      src = registers[src]
    end
    if src != 0
      pc += mov - 1
    end
  end
end

puts registers['a']

# Part 2
prog = input.dup
registers = Hash.new(0)
registers['c'] = 1

pc = 0
while prog[pc]
  op = prog[pc]
  pc += 1
  case op
  when /cpy (.*) (.*)/
    src = $1
    dst = $2
    if src =~ /\d/
      src = src.to_i
    else
      src = registers[src]
    end
    registers[dst] = src
  when /inc (.*)/
    registers[$1] += 1
  when /dec (.*)/
    registers[$1] -= 1
  when /jnz (.*) (.*)/
    src = $1
    mov = $2.to_i
    if src =~ /\d/
      src = src.to_i
    else
      src = registers[src]
    end
    if src != 0
      pc += mov - 1
    end
  end
end

puts registers['a']
