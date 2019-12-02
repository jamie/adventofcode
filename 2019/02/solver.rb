require "advent"
input = Advent.input(2019, 2).split(',').map(&:to_i)

def execute(memory, noun, verb)
  ip = 0
  memory[1] = noun
  memory[2] = verb
  loop do
    case memory[ip]
    when 1
      memory[memory[ip+3]] = memory[memory[ip+1]] + memory[memory[ip+2]]
    when 2
      memory[memory[ip+3]] = memory[memory[ip+1]] * memory[memory[ip+2]]
    else
      break
    end
    ip += 4
  end
  memory[0]
end

puts execute(input.dup, 12, 2)

(0..99).each do |noun|
  (0..99).each do |verb|
    value = execute(input.dup, noun, verb)
    if value == 19690720
      puts noun*100 + verb
      exit
    end
  end
end
