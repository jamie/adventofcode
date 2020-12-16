require "advent"
input = Advent.input

forward = [
  [1, 0], # east
  [0, -1], # south
  [-1, 0], # west
  [0, 1] # north
]

# Part 1

x, y = 0, 0
dir = 0
input.each do |line|
  case line
  when /N(\d+)/
    y += $1.to_i
  when /S(\d+)/
    y -= $1.to_i
  when /E(\d+)/
    x += $1.to_i
  when /W(\d+)/
    x -= $1.to_i
  when /F(\d+)/
    dx, dy = forward[dir]
    x += dx * $1.to_i
    y += dy * $1.to_i
  when /[LR]180/
    dir = (dir + 2) % 4
  when /L90/, /R270/
    dir = (dir - 1) % 4
  when /R90/, /L270/
    dir = (dir + 1) % 4
  else
    raise "Unknown command: #{line}"
  end
end
puts x.abs + y.abs

# Part 2

x, y = 0, 0
wx, wy = 10, 1
dir = 0
input.each do |line|
  case line
  when /N(\d+)/
    wy += $1.to_i
  when /S(\d+)/
    wy -= $1.to_i
  when /E(\d+)/
    wx += $1.to_i
  when /W(\d+)/
    wx -= $1.to_i
  when /F(\d+)/
    x += wx * $1.to_i
    y += wy * $1.to_i
  when /[LR]180/
    wx, wy = -wx, -wy
  when /L90/, /R270/
    wx, wy = -wy, wx
  when /R90/, /L270/
    wx, wy = wy, -wx
  else
    raise "Unknown command: #{line}"
  end
end
puts x.abs + y.abs

