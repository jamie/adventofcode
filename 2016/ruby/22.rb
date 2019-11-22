require "advent"
input = Advent.input(2016, 22)[2..-1]

# Part 1

# Node, Size, Used, Avail, Use%
dfh = input.map { |line| line.chomp.split(/T? +/) }

viable = []

dfh.each do |node_a, size_a, used_a, avail_a, _|
  dfh.each do |node_b, size_b, used_b, avail_b, _|
    next if used_a == "0"
    next if node_a == node_b
    next if used_a.to_i > avail_b.to_i
    viable << [node_a, node_b].sort
  end
end

puts viable.uniq.size

# Part 2

# Node, Size, Used, Avail, Use%
dfh = input.map { |line| line.chomp.split(/T? +/) }

Cell = Struct.new(:used, :size) do
  def empty?
    used.zero?
  end
end

map = []
dfh.each do |node, size, used, avail, _|
  node =~ /x(\d+)-y(\d+)/
  x, y = Regexp.last_match(1).to_i, Regexp.last_match(2).to_i
  map[y] ||= []
  map[y][x] = Cell.new(used.to_i, size.to_i)
end

# threshold = map[0].last.used
# map.each do |row|
#   row.each do |cell|
#     if cell.empty?
#       print '_'
#     elsif cell.used > 100
#       # data very large
#       print '%'
#     elsif cell.size < threshold
#       # size too small for target
#       print '#'
#     else
#       print '.'
#     end
#   end
#   puts
# end

# By inspection of map (above) there is one empty node.
# It takes 64 steps to move that empty space to the top
# right corner (moving the desired data one space left).
# It then takes 5 steps to loop around the data and move
# it an additional space left. The grid is 39 spaces
# wide, so data needs to move left 38 times, and we've
# already moved it once so we need to do 37 cycles.
puts 64 + (5 * 37)
