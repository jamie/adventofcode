facing = :north
location = [0, 0]

def turn(facing, direction)
  case facing
  when :north
    direction == 'R' ? :east : :west
  when :east
    direction == 'R' ? :south : :north
  when :south
    direction == 'R' ? :west : :east
  when :west
    direction == 'R' ? :north : :south
  end
end

def walk(location, facing, distance)
  x, y = location
  distance = -distance if facing == :south or facing == :west
  (facing == :north || facing == :south) ?
    [x, y+distance] :
    [x+distance, y]
end

File.read('input').scan(/([RL])(\d+)/).each do |direction, distance|
  facing = turn(facing, direction)
  location = walk(location, facing, distance.to_i)
end

puts location.map(&:abs).inject(:+)
