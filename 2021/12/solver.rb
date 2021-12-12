require "advent"
input = Advent.input

inpuxt = <<~STR.split("\n")
  start-A
  start-b
  A-c
  A-b
  b-d
  A-end
  b-end
STR

# Part 1

connections = input.map{|line|
  line.split("-")
}
connections += connections.map(&:reverse)

def explore(connections, path=['start'], &blk)
  connections.map do |from, to|
    next unless path[-1] == from
    next if path.include?(to) && to.downcase == to
    yield path + [to] if to == 'end' 
    next path + [to] if to == 'end'
    explore(connections, path + [to], &blk)
  end.compact
end

paths = []
found = explore(connections) do |path|
  paths << path
end
puts paths.size

# Part 2

def explore_more(connections, path=['start'], &blk)
  connections.each do |from, to|
    next unless path[-1] == from
    next if to == 'start'

    next_path = path + [to]

    if to == 'end'
      yield next_path
      next
    end

    smalls = next_path.select{|room| room.downcase == room}
    next if smalls.size - smalls.uniq.size > 1

    explore_more(connections, next_path, &blk)
  end
end

paths = []
found = explore_more(connections) do |path|
  paths << path
end
puts paths.size
