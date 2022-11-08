require "advent"
prog = Advent.input

require "intcode"

PIXEL = {nil => " ", 0 => "#", 1 => ".", 2 => "o"}.freeze

def draw(map)
  xs, ys = map.keys.transpose
  ys.min.upto(ys.max) do |j|
    xs.min.upto(xs.max) do |i|
      print PIXEL[map[[i, j]]]
    end
    puts
  end
end

map = {}
map[[0, 0]] = 1

# Part 1, fully map and record distance to O2 meter
droid = Intcode.new(prog)
oxygen_distance = nil

queue = [[1], [2], [3], [4]]
loop do
  break if queue.empty?
  path = queue.shift
  x = path.count(4) - path.count(3)
  y = path.count(2) - path.count(1)

  output = []
  droid.reset.input!(path).output!(output)
  droid.execute

  map[[x, y]] = output.last

  next if output.last == 0
  oxygen_distance = path.size if output.last == 2

  queue << path + [1] unless map[[x, y - 1]] # North
  queue << path + [2] unless map[[x, y + 1]] # South
  queue << path + [3] unless map[[x - 1, y]] # West
  queue << path + [4] unless map[[x + 1, y]] # East
end

puts oxygen_distance

# draw(map)

# Part 2, flood-fill oxygen
oxy = [map.key(2)]
time = 0
loop do
  break if map.values.count(1).zero?

  time += 1
  this_oxy = oxy
  oxy = []
  this_oxy.each do |x, y|
    [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]].each do |x2, y2|
      next unless map[[x2, y2]] == 1
      map[[x2, y2]] = 2
      oxy << [x2, y2]
    end
  end
end

puts time
