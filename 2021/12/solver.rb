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

connections = Hash.new { |h, k| h[k] = [] }
input.each do |line|
  a, b = line.split("-")
  connections[a] << b unless b == "start"
  connections[b] << a unless a == "start"
end
connections.delete("end")

# Part 1

def explore(connections, path = ["start"], &blk)
  connections[path.last].each do |to|
    next if path.include?(to) && to.downcase == to

    next_path = path + [to]
    if to == "end"
      yield next_path
    else
      explore(connections, next_path, &blk)
    end
  end
end

paths = []
explore(connections) { |path| paths << path }
puts paths.size

# Part 2

def explore_more(connections, path = ["start"], &blk)
  connections[path.last].each do |to|
    next_path = path + [to]
    if to == "end"
      yield next_path
    else
      smalls = next_path.select { |room| room.downcase == room }
      if smalls.size - smalls.uniq.size < 2
        explore_more(connections, next_path, &blk)
      end
    end
  end
end

paths = []
explore_more(connections) { |path| paths << path }
puts paths.size
