require "advent"
input = Advent.input

# Part 1
# Attempt the third, actually building the maze

class Room < Struct.new(:x, :y, :dist)
  attr_accessor :east, :west, :north, :south

  def add_room(direction)
    case direction
    when "E"
      return east if east
      room = Room.new(x + 1, y, dist + 1)
      self.east = room
      room.west = self
    when "W"
      return west if west
      room = Room.new(x - 1, y, dist + 1)
      self.west = room
      room.east = self
    when "N"
      return north if north
      room = Room.new(x, y - 1, dist + 1)
      self.north = room
      room.south = self
    when "S"
      return south if south
      room = Room.new(x, y + 1, dist + 1)
      self.south = room
      room.north = self
    else
      fail "Unknown direction: #{direction}"
    end
    room
  end

  def to_s
    return "╋" if [x, y] == [0, 0]

    case [!!east, !!west, !!north, !!south]
    when [false, false, false, false] then fail "Empty Room!"
    when [false, false, false, true] then "╷" # south
    when [false, false, true, false] then "╵" # north
    when [false, false, true, true] then "│"
    when [false, true, false, false] then "╴" # west
    when [false, true, false, true] then "┐"
    when [false, true, true, false] then "┘"
    when [false, true, true, true] then "┤"
    when [true, false, false, false] then "╶" # east
    when [true, false, false, true] then "┌"
    when [true, false, true, false] then "└"
    when [true, false, true, true] then "├"
    when [true, true, false, false] then "─"
    when [true, true, false, true] then "┬"
    when [true, true, true, false] then "┴"
    when [true, true, true, true] then "┼"
    end
  end
end

home = Room.new(0, 0, 0)
map = {[0, 0] => home}
stack = [home]
input.split("").each do |char|
  case char
  when "^", "$"
    next
  when /[NEWS]/
    room = stack[-1].add_room(char)
    map[[room.x, room.y]] = room
    stack[-1] = room
  when "("
    stack << stack[-1]
  when "|"
    stack.pop
    stack << stack[-1]
  when ")"
    stack.pop
  end
end

xs = map.keys.map(&:first).uniq.sort
ys = map.keys.map(&:last).uniq.sort

# ys.each do |y|
#   xs.each do |x|
#     print map[[x, y]].to_s
#   end
#   puts
# end

puts map.values.map(&:dist).max

# Part 2, counting
puts map.values.map(&:dist).count { |e| e >= 1000 }
