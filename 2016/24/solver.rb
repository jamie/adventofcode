require "advent"
require "astar"
input = Advent.input

xinput = <<STR.split("\n")
###########
#0.1.....2#
#.#######.#
#4.......3#
###########
STR

def map_find_xy(node, input)
  row = input.detect {|line| line =~ /#{node}/}
  y = input.index(row)
  x = row.index(node)
  [x, y]
end

numbers = input.join.scan(/[0-9]/).sort
locations = Hash[numbers.map{|n| [n, map_find_xy(n, input)]}]

distances = {}
numbers.each do |start|
  numbers.each do |goal|
    if start < goal
      distance = astar_map(input, locations[start], locations[goal]).size - 1
      distances[start] ||= {}
      distances[start][goal] = distance
      distances[goal] ||= {}
      distances[goal][start] = distance
    end
  end
end

# Part 1
paths = [[["0"], 0]]
loop do
  path, distance = paths.sort_by(&:last).first

  if path.size == distances.size
    puts distance
    break
  end

  numbers.each do |n|
    next if path.include?(n)
    cost = distances[path.last][n]
    paths << [path + [n], distance + cost]
  end

  paths.delete([path, distance])
end

# Part 2
loop do
  path, distance = paths.sort_by(&:last).first
  paths.delete([path, distance])

  if path.size == distances.size + 1
    puts distance
    break
  end

  if path.size == distances.size
    cost = distances[path.last]["0"]
    paths << [path + ["0"], distance + cost]
  else
    numbers.each do |n|
      next if path.include?(n)
      cost = distances[path.last][n]
      paths << [path + [n], distance + cost]
    end
  end
end
