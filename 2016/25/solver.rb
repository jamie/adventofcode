require "advent"
input = Advent.input

require "assembunny"

cpu = Assembunny.new(input)
10_000.times do |i|
  cpu.reset!
  cpu.set_register("a", i)
  cpu.run
  # p [i, cpu.output]
  if cpu.output == [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
    puts i
    exit
  end
end
