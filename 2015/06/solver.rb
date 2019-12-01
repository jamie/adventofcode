require "advent"
input = Advent.input(2015, 6)

# Part 1
class Light
  def initialize
    off
  end

  def on?
    @state == :on
  end

  def on
    @state = :on
  end

  def off
    @state = :off
  end

  def toggle
    on? ? off : on
  end
end

lights = Array.new(1000) do
  Array.new(1000) do
    Light.new
  end
end

input.each do |line|
  # turn on 606,361 through 892,600
  # turn off 448,208 through 645,684
  # toggle 50,472 through 452,788
  command = line.match(/([a-z]+) (\d+),(\d+) through (\d+),(\d+)/)
  x = [command[2].to_i, command[4].to_i].sort
  y = [command[3].to_i, command[5].to_i].sort
  action = command[1]
  x[0].upto(x[1]) do |_x|
    y[0].upto(y[1]) do |_y|
      lights[_x][_y].send(action)
    end
  end
end

puts lights.flatten.select { |light| light.on? }.size

# Part 2
class Light
  attr_reader :bright

  def initialize
    @bright = 0
  end

  def on?
    @bright > 0
  end

  def on
    @bright += 1
  end

  def off
    @bright -= 1 if on?
  end

  def toggle
    @bright += 2
  end
end

lights = Array.new(1000) do
  Array.new(1000) do
    Light.new
  end
end

input.each do |line|
  # turn on 606,361 through 892,600
  # turn off 448,208 through 645,684
  # toggle 50,472 through 452,788
  command = line.match(/([a-z]+) (\d+),(\d+) through (\d+),(\d+)/)
  x = [command[2].to_i, command[4].to_i].sort
  y = [command[3].to_i, command[5].to_i].sort
  action = command[1]
  x[0].upto(x[1]) do |_x|
    y[0].upto(y[1]) do |_y|
      lights[_x][_y].send(action)
    end
  end
end

puts lights.flatten.map { |light| light.bright }.inject(&:+)
