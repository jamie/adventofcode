require 'advent'
input = Advent.input(2017, 24)
components = input.map{|line| line.split('/').map(&:to_i).sort }.sort

# Pre-attach edges with only 2 instances, reduce combinatorics slightly
(1..50).each do |i|
  nodes = components.select{|node| node.include?(i)}
  if nodes.size == 2
    components -= nodes
    if nodes[0].last == nodes[1].first
      components << nodes[0] + nodes[1]
    elsif nodes[1].last == nodes[0].first
      components << nodes[1] + nodes[0]
    elsif nodes[0].first == nodes[1].first
      components << nodes[0].reverse + nodes[1]
    elsif nodes[0].last == nodes[1].last
      components << nodes[0] + nodes[1].reverse
    else
      p nodes
      exit
    end
  end
end

$strongest = 0
$longest = [0, 0]

def find_strongest(bridge, comps)
  strength = bridge.flatten.inject(&:+)
  size = bridge.flatten.size/2

  if strength > $strongest
    $strongest = strength
  end
  if size > $longest[0]
    $longest = [size, strength]
  elsif size == $longest[0] && strength > $longest[1]
    $longest = [size, strength]
  end

  comps.each do |node|
    if bridge.last.last == node.first
      find_strongest(bridge+[node], comps-[node])
    elsif bridge.last.last == node.last
      find_strongest(bridge+[node.reverse], comps-[node])
    end
  end
end

find_strongest([[0]], components)
puts $strongest
puts $longest[1]
