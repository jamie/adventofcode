require "advent"
input = Advent.input(2016, 1)

# Part 1
facing = :north
location = [0, 0]

def turn(facing, direction)
  case facing
  when :north
    direction == "R" ? :east : :west
  when :east
    direction == "R" ? :south : :north
  when :south
    direction == "R" ? :west : :east
  when :west
    direction == "R" ? :north : :south
  end
end

def walk(location, facing, distance)
  x, y = location
  distance = -distance if facing == :south or facing == :west
  (facing == :north || facing == :south) ?
    [x, y + distance] :
    [x + distance, y]
end

input.scan(/([RL])(\d+)/).each do |direction, distance|
  facing = turn(facing, direction)
  location = walk(location, facing, distance.to_i)
end

puts location.map(&:abs).inject(:+)

# Part 2
facing = :north
location = [0, 0]

def turn(facing, direction)
  case facing
  when :north
    direction == "R" ? :east : :west
  when :east
    direction == "R" ? :south : :north
  when :south
    direction == "R" ? :west : :east
  when :west
    direction == "R" ? :north : :south
  end
end

def walk(location, facing, distance)
  x, y = location
  distance = -distance if facing == :south or facing == :west
  (facing == :north || facing == :south) ?
    [x, y + distance] :
    [x + distance, y]
end

history = [[0, 0]]

input.scan(/([RL])(\d+)/).each do |direction, distance|
  facing = turn(facing, direction)
  distance.to_i.times do
    location = walk(location, facing, 1)
    if history.include? location
      puts location.map(&:abs).inject(:+)
      exit
    end
    history << location
  end
end
