require "advent"
input = Advent.input(2019, 2)

require "intcode"
intcode = Intcode.new(input)

# Part 1
puts intcode.reset(12, 2).execute

# Part 2
(0..99).each do |noun|
  (0..99).each do |verb|
    value = intcode.reset(noun, verb).execute
    if value == 19690720
      puts noun * 100 + verb
      exit
    end
  end
end
