require "advent"
input = Advent.input(2019, 2)

require "intcode"
intcode = Intcode.new(input)

# Part 1
intcode.reset(12, 2).execute
puts intcode.memory[0]

# Part 2
(0..99).each do |noun|
  (0..99).each do |verb|
    intcode.reset(noun, verb).execute
    if intcode.memory[0] == 19690720
      puts noun * 100 + verb
      exit
    end
  end
end
