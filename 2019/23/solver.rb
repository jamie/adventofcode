require "advent"
prog = Advent.input

require "intcode"

computers = 50.times.map do |i|
  Intcode.new(prog).input!([i, -1])
end

nat = []
last_nat = []

out = catch :done do
  loop do
    idle = true
    computers.each do |comp|
      comp.execute
      output = comp.output

      while output.size >= 3
        idle = false
        addr = comp.output.shift

        if addr == 255
          nat = [comp.output.shift, comp.output.shift]
          puts nat[1] if last_nat.empty? # Part 1
        else
          computers[addr].input << comp.output.shift << comp.output.shift
        end
      end
      comp.input << -1
    end

    if idle
      computers[0].input << nat[0] << nat[1]
      if last_nat[1] == nat[1] # Part 2
        puts nat[1]
        exit
      end
      last_nat = nat
    end
  end
end
puts out
