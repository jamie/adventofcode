require 'advent'
input = Advent.input(2017, 12)

index = Hash[input.map{|line|
  line =~ /(\d+) <-> ([0-9, ]+)/
  room, neighbours = $1, $2.split(', ')
  [room, neighbours]
}]

groups = 0

loop do
  to_visit = [index.keys.first]
  seen = []
  while prog = to_visit.shift
    seen << prog
    index[prog].each do |neighbour|
      to_visit << neighbour unless seen.include?(neighbour)
    end
  end

  groups += 1
  puts seen.size if groups == 1 # part 1

  seen.each do |prog|
    index.delete(prog)
  end
  break if index.empty?
end
puts groups # part 2
