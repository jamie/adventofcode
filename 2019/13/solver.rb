require "advent"
prog = Advent.input

require "intcode"

def render(screen)
  screen.each do |row|
    row.each do |tile|
      out = {
        0 => " ",
        1 => "#",
        2 => "-",
        3 => "^",
        4 => "o"
      }[tile] || "?"
      print out
    end
    puts
  end
end

# Part 1
input = []
output = []
arcade = Intcode.new(prog).output!(output)

arcade.execute

screen = []
loop do
  break if output.empty?
  x = output.shift
  y = output.shift
  tile = output.shift
  screen[y] ||= []
  screen[y][x] = tile
end

puts screen.flatten.count(2)

# Part 2
input = []
output = []
arcade = Intcode.new(prog).output!(output).input!(input)
arcade.poke(0, 2)

screen = []
score = 0
ball_pos = paddle_pos = 0
loop do
  arcade.execute
  loop do
    break if output.empty?
    x = output.shift
    y = output.shift
    tile = output.shift
    if x == -1
      score = tile
    else
      screen[y] ||= []
      screen[y][x] = tile
      paddle_pos = x if tile == 3
      ball_pos = x if tile == 4
    end
  end
  input << (ball_pos <=> paddle_pos)
  break if arcade.halted
end

puts score
