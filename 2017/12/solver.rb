require "advent"
input = Advent.input

index = Hash[input.map do |line|
               line =~ /(\d+) <-> ([0-9, ]+)/
               room, neighbours = Regexp.last_match(1), Regexp.last_match(2).split(", ")
               [room, neighbours]
             end]

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
