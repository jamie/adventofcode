require "advent"
input = Advent.input

require "intcode"

# Part 1
SIZE = 50
scan = SIZE.times.map { [] }

SIZE.times do |y|
  SIZE.times do |x|
    scan[x][y] = Intcode.new(input).input!([x, y]).execute
  end
end

puts scan.flatten.count(1)

# Part 2
class Scanner
  attr_reader :x, :y

  def initialize(input, x, y)
    @input = input
    @x, @y = x, y
  end

  def peek?(dx: 0, dy: 0)
    Intcode.new(@input).input!([@x + dx, @y + dy]).execute == 1
  end

  def down!
    @y += 1
  end

  def right!
    @x += 1
  end
end

# Start
scanner = Scanner.new(input, scan.size, scan.last.index(1))

# Fast Down, staying left, until we have 100-sized rows
loop do
  break if scanner.peek?(dx: 99)
  scanner.down!
  scanner.right! unless scanner.peek?
end

# Slow Down, staying 100 from right, until we have 100-sized columns
loop do
  break if scanner.peek?(dy: 99)
  scanner.down!
  scanner.right! while scanner.peek?(dx: 100) # Careful about for off-by-ones
end

puts scanner.x * 10000 + scanner.y
