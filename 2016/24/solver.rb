require "advent"
input = Advent.input

# input = <<STR.split("\n")
# ###########
# #0.1.....2#
# #.#######.#
# #4.......3#
# ###########
# STR

PATH = ".".freeze
PATHRENDER = "#".freeze
WALL = "#".freeze

Loc = Struct.new(:x, :y, :s, :neighbours) do
  def inspect
    "<Loc x:#{x}, y:#{y}, s:#{s}>"
  end

  def delete
    neighbours.each do |n|
      n.neighbours.delete(self)
    end
  end
end

def render(map)
  xs = map.keys.map(&:first)
  ys = map.keys.map(&:last)
  (ys.min..ys.max).each do |y|
    (xs.min..xs.max).each do |x|
      if map[[x, y]]
        print map[[x, y]].s.gsub(PATH, PATHRENDER)
      else
        print " "
      end
    end
    puts
  end
end

all_locs = {}
locations = []

input.each.with_index do |row, y|
  row.split(//).each.with_index do |cell, x|
    case cell
    when WALL
      # skip

    when PATH
      loc = Loc.new(x, y, cell, [])
      all_locs[[x, y]] = loc
      # link horizontal
      if all_locs[[x - 1, y]]
        all_locs[[x - 1, y]].neighbours << loc
        loc.neighbours << all_locs[[x - 1, y]]
      end
      # link vertical
      if all_locs[[x, y - 1]]
        all_locs[[x, y - 1]].neighbours << loc
        loc.neighbours << all_locs[[x, y - 1]]
      end
    when "0".."9"
      loc = Loc.new(x, y, cell, [])
      locations[cell.to_i] = loc
      all_locs[[x, y]] = loc
      # link horizontal
      if all_locs[[x - 1, y]]
        all_locs[[x - 1, y]].neighbours << loc
        loc.neighbours << all_locs[[x - 1, y]]
      end
      # link vertical
      if all_locs[[x, y - 1]]
        all_locs[[x, y - 1]].neighbours << loc
        loc.neighbours << all_locs[[x, y - 1]]
      end
    end
  end
end

# Manually trim some additional paths
[
  [3, 7],
  [1, 35],
  [1, 23],
  [7, 13],
  [3, 29],
  [7, 27],
  [1, 31],
  [5, 3],
  [23, 3],
  [31, 9],
  [35, 9],
  [37, 13],
  [73, 1],
  [85, 1],
  [89, 1],
  [89, 3],
  [137, 37],
  [155, 37],
  [157, 29],
  [159, 29],
  [161, 10],
  [165, 3],
  [169, 31],
  [180, 37],
  [181, 1],
].each do |x, y|
  all_locs[[x, y]].delete
  all_locs.delete([x, y])
end

size = all_locs.size + 1
while all_locs.size < size
  size = all_locs.size
  all_locs.to_a.each do |key, loc|
    # Trim dead ends
    if loc.s == PATH && loc.neighbours.size < 2
      loc.delete
      all_locs.delete(key)
    end
  end
end

print (1..18).map { |i| "         #{i % 10}" }.join
puts
print (((1..9).to_a + [0]) * 18).join
puts

render(all_locs)

print (((1..9).to_a + [0]) * 18).join
puts

puts all_locs.size
