require "advent"
input = Advent.input

# Part 1

x, y = 0, 0
input.each do |line|
  case line
  when /forward (\d+)/
    x += $1.to_i
  when /down (\d+)/
    y += $1.to_i
  when /up (\d+)/
    y -= $1.to_i
  end
end
puts x * y

# Part 2

x, y, aim = 0, 0, 0
input.each do |line|
  case line
  when /forward (\d+)/
    x += $1.to_i
    y += $1.to_i * aim
  when /down (\d+)/
    aim += $1.to_i
  when /up (\d+)/
    aim -= $1.to_i
  end
end
puts x * y
