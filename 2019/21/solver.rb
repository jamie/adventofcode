require "advent"
prog = Advent.input

require "intcode"

# Part 1

# A-D: RO solid ground distance 1-4
# T temp register
# J jump register
# Jumping travels 4 steps

# Jump if D AND !(A OR B OR C)

springscript = <<~SPRINGSCRIPT.bytes
  NOT A T
  NOT B J
  OR J T
  NOT C J
  OR T J
  AND D J
  WALK
SPRINGSCRIPT
output = []
springbot = Intcode.new(prog).input!(springscript).output!(output)

puts springbot.execute

# Part 2

# E-I: RO solid ground distance 5-9

# Jump if D AND (H OR E) AND !(A OR B OR C)

springscript = <<~SPRINGSCRIPT.bytes
  NOT A T
  NOT B J
  OR J T
  NOT C J
  OR T J
  AND D J
  NOT H T
  NOT T T
  OR E T
  AND T J
  RUN
SPRINGSCRIPT
output = []
springbot = Intcode.new(prog).input!(springscript).output!(output)

puts springbot.execute
