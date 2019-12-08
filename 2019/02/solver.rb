require "advent"
input = Advent.input(2019, 2)

require "intcode"
intcode = Intcode.new(input)

# Part 1
intcode.reset.poke(1, 12).poke(2, 2).execute
puts intcode.peek(0)

# Part 2
(0..99).each do |noun|
  (0..99).each do |verb|
    intcode.reset.poke(1, noun).poke(2, verb).execute
    if intcode.peek(0) == 19690720
      puts noun * 100 + verb
      exit
    end
  end
end
