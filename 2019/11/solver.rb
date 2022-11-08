require "advent"
prog = Advent.input

require "intcode"
require "gridwalker"

def debug(paint)
  x1 = paint.keys.map(&:first).min
  x2 = paint.keys.map(&:first).max
  y1 = paint.keys.map(&:last).min
  y2 = paint.keys.map(&:last).max
  y1.upto(y2) do |y|
    x1.upto(x2) do |x|
      print(paint[[x, y]] == 1 ? "#" : " ")
    end
    puts
  end
end

# Part 1
input = []
output = []
robot = Intcode.new(prog).input!(input).output!(output)

painter = GridWalker.new
paint = {}
loop do
  break if robot.halted

  input << (paint[painter.pos] || 0)
  robot.execute
  paint[painter.pos] = output.shift
  if output.shift == 0
    painter.left!.forward!
  else
    painter.right!.forward!
  end
end
puts paint.size

# Part 2
input = []
output = []
robot.reset.input!(input).output!(output)

painter = GridWalker.new
paint = {painter.pos => 1}
loop do
  break if robot.halted

  input << (paint[painter.pos] || 0)
  robot.execute
  paint[painter.pos] = output.shift
  if output.shift == 0
    painter.left!.forward!
  else
    painter.right!.forward!
  end
end
debug(paint)
