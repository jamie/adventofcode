require "advent"
input = Advent.input

Virus = Struct.new(:x, :y, :dir) do
  TURN_RIGHT = {
    up: :right,
    right: :down,
    down: :left,
    left: :up
  }.freeze
  TURN_LEFT = {
    up: :left,
    left: :down,
    down: :right,
    right: :up
  }.freeze
  TURN_AROUND = {
    up: :down,
    down: :up,
    left: :right,
    right: :left
  }.freeze

  def turn_right!
    self.dir = TURN_RIGHT[dir]
  end

  def turn_left!
    self.dir = TURN_LEFT[dir]
  end

  def turn_around!
    self.dir = TURN_AROUND[dir]
  end

  def step!
    case dir
    when :up then self.y -= 1
    when :down then self.y += 1
    when :left then self.x -= 1
    when :right then self.x += 1
    end
  end
end

def puts_grid(virus, infections)
  return # this is just debug output
  (-5..30).each do |y|
    (-5..30).each do |x|
      if virus.x == x && virus.y == y
        print "["
      elsif virus.x == x - 1 && virus.y == y
        print "]"
      else
        print " "
      end
      print infections[y][x]
    end
    puts
  end
end

# Part 1, two step
virus = Virus.new(input.size / 2, input.size / 2, :up)

infections = Hash.new { |h, k| h[k] = Hash.new { "." } }
input.each_with_index do |row, y|
  row.split("").each_with_index do |cell, x|
    infections[y][x] = cell.chomp
  end
end

infect_count = 0
10_000.times do
  case infections[virus.y][virus.x]
  when "."
    virus.turn_left!
    infections[virus.y][virus.x] = "#"
    infect_count += 1
  when "#"
    virus.turn_right!
    infections[virus.y][virus.x] = "."
  end
  virus.step!
end

puts_grid(virus, infections)
puts infect_count

# Part 2, four step
virus = Virus.new(input.size / 2, input.size / 2, :up)

infections = Hash.new { |h, k| h[k] = Hash.new { "." } }
input.each_with_index do |row, y|
  row.split("").each_with_index do |cell, x|
    infections[y][x] = cell
  end
end
puts_grid(virus, infections)

infect_count = 0
10_000_000.times do
  case infections[virus.y][virus.x]
  when "."
    virus.turn_left!
    infections[virus.y][virus.x] = "W"
  when "W"
    infect_count += 1
    infections[virus.y][virus.x] = "#"
  when "#"
    virus.turn_right!
    infections[virus.y][virus.x] = "F"
  when "F"
    virus.turn_around!
    infections[virus.y][virus.x] = "."
  end
  virus.step!
end

puts_grid(virus, infections)
puts infect_count
