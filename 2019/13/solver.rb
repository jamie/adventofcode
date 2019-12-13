require "advent"
prog = Advent.input(2019, 13)

require "intcode"

def render(screen)
  screen.each do |row|
    row.each do |tile|
      out = {
        0 => " ",
        1 => "#",
        2 => "-",
        3 => "^",
        4 => "o",
      }[tile] || "?"
      print out
    end
    puts
  end
end

# Part 1
output = []
input = []
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
