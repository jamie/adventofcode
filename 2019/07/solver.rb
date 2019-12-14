require "advent"
input = Advent.input()

require "intcode"

amps = (1..5).map { Intcode.new(input) }

# Part 1
max = 0
(0..4).to_a.permutation(5) do |phases|
  [amps, phases].transpose.each do |amp, phase|
    amp.reset.input!([phase])
  end
  amps[0].input << 0
  amps[0].chain!(*amps[1..4])

  out = amps.map do |amp|
    amp.execute
  end
  max = [max, out.last].max
end
puts max

# Part 2
max = 0
(5..9).to_a.permutation(5) do |phases|
  [amps, phases].transpose.each do |amp, phase|
    amp.reset.input!([phase])
  end
  amps[0].input << 0
  amps[0].chain!(*amps[1..4], amps[0])

  loop do
    amp = amps.shift
    input = amp.execute

    amps << amp

    if amps.all?(&:halted)
      max = [max, input].max
      break
    end
  end
end
puts max
