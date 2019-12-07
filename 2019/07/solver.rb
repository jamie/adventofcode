require "advent"
input = Advent.input(2019, 7)

require 'intcode'

amps = (1..5).map { Intcode.new(input) }

max = 0
(0..4).each do |a|
  (0..4).each do |b|
    (0..4).each do |c|
      (0..4).each do |d|
        (0..4).each do |e|
          phase = [a, b, c, d, e]
          next unless phase.uniq == phase
          out = amps.inject(0) do |inval, amp|
            amp.reset.execute([phase.shift, inval])
          end
          max = [max, out].max
        end
      end
    end
  end
end
puts max

max = 0
(5..9).each do |a|
  (5..9).each do |b|
    (5..9).each do |c|
      (5..9).each do |d|
        (5..9).each do |e|
          phases = [a, b, c, d, e]
          next unless phases.uniq == phases
          amps.each(&:reset)

          input = [0]
          output = nil

          i = 0
          loop do; i += 1
            amp = amps.shift
            phase = phases.shift
            input.unshift(phase) if phase

            output = amp.execute(input)

            input = [output]
            amps << amp

            break if amps.all?(&:halted)
          end

          max = [max, output].max
        end
      end
    end
  end
end
puts max
