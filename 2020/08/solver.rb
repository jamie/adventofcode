require "advent"
input = Advent.input

# Unified solver
def run(input)
  acc = 0
  ip = 0
  seen = []

  loop do
    return [acc, false] if seen.include?(ip)
    seen << ip

    case input[ip]
    when /acc (.*)/
      acc += $1.to_i
      ip += 1
    when /jmp (.*)/
      ip += $1.to_i
    when /nop (.*)/
      ip += 1
    when nil
      return [acc, true]
    end
  end
end

# Part 1
acc, _ = run(input)
puts acc

# Part 2

acc = nil
input.each_with_index do |cmd, i|
  new_input = input.dup
  if cmd =~ /jmp (.*)/
    new_input[i] = "nop #{$1}"
  elsif cmd =~ /nop (.*)/
    new_input[i] = "jmp #{$1}"
  else
    next
  end

  acc, stopped = run(new_input)
  break if stopped
end
puts acc
