input = File.readlines('input/23')

require './bytecode-interpreter'

class MulCountingProgram < Program
  attr_reader :mul_count

  def initialize(*)
    super
    @mul_count = 0
  end

  def mul(*)
    super
    @mul_count += 1
  end
end

prog = MulCountingProgram.new(input)
prog.run
puts prog.mul_count

# part 2: Manually convert assembly to ruby, and then hand-optimize a lot

puts 109_900.step(126_900, 17).select{|b|
  2.upto(Math.sqrt(b)).any?{|d| b % d == 0}
}.count
