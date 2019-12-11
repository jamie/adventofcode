require "advent"
input = Advent.input(2019, 11)

require "intcode"

def debug(paint)
  x1 = paint.keys.map(&:first).min
  x2 = paint.keys.map(&:first).max
  y1 = paint.keys.map(&:last).min
  y2 = paint.keys.map(&:last).max
  y1.upto(y2) do |y|
    x1.upto(x2) do |x|
      print (paint[[x,y]] == 1 ? '#' : ' ')
    end
    puts
  end
end

# Part 1
robot = Intcode.new(input)

dir = :n
turns = {
  :n => [:w, :e],
  :e => [:n, :s],
  :s => [:e, :w],
  :w => [:s, :n],
}
x = y = 0
paint = {}
input = []
output = []
robot.input!(input).output!(output)
loop do
  break if robot.halted

  input << (paint[[x, y]] || 0)
  robot.execute
  paint[[x, y]] = output.shift
  dir = turns[dir][output.shift]
  case dir
  when :n; y -= 1
  when :s; y += 1
  when :e; x += 1
  when :w; x -= 1
  end
end
puts paint.size

# Part 2
robot.reset

dir = :n
turns = {
  :n => [:w, :e],
  :e => [:n, :s],
  :s => [:e, :w],
  :w => [:s, :n]
}
x = y = 0
paint = {[x, y] => 1}
input = []
output = []
robot.input!(input).output!(output)
loop do
  break if robot.halted

  input << (paint[[x, y]] || 0)
  robot.execute
  paint[[x, y]] = output.shift
  dir = turns[dir][output.shift]
  case dir
  when :n; y -= 1
  when :s; y += 1
  when :e; x += 1
  when :w; x -= 1
  end
end

debug(paint)

