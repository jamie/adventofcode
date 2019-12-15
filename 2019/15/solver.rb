require "advent"
prog = Advent.input

require "intcode"

def pixel(i)
  {
    nil => " ",
    0 => "#",
    1 => ".",
    2 => "o",
  }[i]
end

def draw(map)
  xs, ys = map.keys.transpose
  ys.min.upto(ys.max) do |j|
    xs.min.upto(xs.max) do |i|
      print pixel(map[[i, j]])
    end
    puts
  end
end

queue = [[1], [2], [3], [4]]

map = {}
map[[0, 0]] = 1

# Part 1, fully map and record distance to O2 meter
oxygen_distance = nil
max_distance = 0

droid = Intcode.new(prog)
loop do
  break if queue.empty?
  path = queue.shift
  x = path.count(4) - path.count(3)
  y = path.count(2) - path.count(1)
  next if map[[x, y]]

  output = []
  droid.reset.input!(path).output!(output)
  droid.execute

  map[[x, y]] = output.last

  next if output.last == 0
  oxygen_distance = path.size if output.last == 2
  max_distance = [max_distance, path.size].max

  queue << path + [1]
  queue << path + [2]
  queue << path + [3]
  queue << path + [4]
end

puts oxygen_distance

# draw(map)

# Part 2, flood-fill oxygen
x, y = map.key(2)
oxy = [[x, y]]
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
