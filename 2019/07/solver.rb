require "advent"
input = Advent.input(2019, 7)

require 'intcode'

amps = (1..5).map { Intcode.new(input) }

# Part 1
max = 0
(0..4).to_a.permutation(5) do |phase|
  next unless phase.uniq == phase
  out = amps.inject(0) do |inval, amp|
    amp.reset.execute([phase.shift, inval])
  end
  max = [max, out].max
end
puts max

# Part 2
max = 0
(5..9).to_a.permutation(5) do |phases|
  next unless phases.uniq == phases

  amps.each(&:reset)
  input = 0

  loop do
    amp = amps.shift
    phase = phases.shift

    input = amp.execute([phase, input].compact)

    amps << amp

    if amps.all?(&:halted)
      max = [max, input].max
      break
    end
  end
end
puts max
