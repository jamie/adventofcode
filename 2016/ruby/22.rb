input = File.readlines('input')[2..-1]

# Node, Size, Used, Avail, Use%
dfh = input.map{|line| line.chomp.split(/T? +/)}

viable = []

dfh.each do |node_a, size_a, used_a, avail_a, _|
  dfh.each do |node_b, size_b, used_b, avail_b, _|
    next if used_a == '0'
    next if node_a == node_b
    next if used_a.to_i > avail_b.to_i
    viable << [node_a, node_b].sort
  end
end

puts viable.uniq.size
require 'pp'
input = File.readlines('input')[2..-1]

# Node, Size, Used, Avail, Use%
dfh = input.map{|line| line.chomp.split(/T? +/)}

map = []
dfh.each do |node, size, used, avail, _|
  node =~ /x(\d+)-y(\d+)/
  x, y = $1.to_i, $2.to_i
  map[y] ||= []
  map[y][x] = [used.to_i, size.to_i]
end

threshold = 70

map.each do |row|
  row.each do |cell|
    if cell[0] > threshold
      # data very large
      print '%'
    elsif cell[1] < threshold
      # size too small for target
      print '#'
    elsif cell[0].zero?
      print '_'
    else
      print '.'
    end
  end
  puts
end

# viable = []
#
# dfh.each do |node_a, size_a, used_a, avail_a, _|
#   dfh.each do |node_b, size_b, used_b, avail_b, _|
#     next if used_a == '0'
#     next if node_a == node_b
#     next if used_a.to_i > avail_b.to_i
#     viable << [node_a, node_b].sort
#   end
# end
#
# puts viable.uniq.size
