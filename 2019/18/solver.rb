require "advent"
input = Advent.input

require "priority_deque"

input = <<STR.split("\n") # 138
#################
#i.G..c...e..H.p#
########.########
#j.A..b...f..D.o#
########@########
#k.E..a...g..B.n#
########.########
#l.F..d...h..C.m#
#################
STR

input = <<STR.split("\n") # 8
#########
#b.A.@.a#
#########
STR

map = {}
input.each_with_index do |row, y|
  row.split(//).each_with_index do |cell, x|
    next if cell == "#" # Skip walls, uninteresting
    map[[x, y]] = cell
  end
end

start = map.key("@")

keys = "a".upto("z").select { |key| map.key(key) }
locked = "A".upto("Z").select { |key| map.key(key) }

distances ||= {}
["@", ("a".."z").to_a].flatten.each do |src_key|
  src = map.key(src_key)

  queue = [[src, 0, []]]
  seen = []
  loop do
    break if queue.empty?
    cell, dist, doors = queue.shift
    p [:distance, src_key, dist]

    next unless map[cell] # skip walls

    unless map[cell] == "."
      if keys.include? map[cell] # key
        distances[[src, cell]] ||= [dist, doors.dup.map(&:downcase)]
        distances[[cell, src]] ||= [dist, doors.dup.map(&:downcase)]
      end

      if locked.include? map[cell] # door
        doors += [map[cell]]
      end
    end

    seen << cell
    x, y = cell
    dist += 1
    queue << [[x + 1, y], dist, doors] unless seen.include?([x + 1, y])
    queue << [[x - 1, y], dist, doors] unless seen.include?([x - 1, y])
    queue << [[x, y + 1], dist, doors] unless seen.include?([x, y + 1])
    queue << [[x, y - 1], dist, doors] unless seen.include?([x, y - 1])
  end
end

queue = PriorityDeque.new(:min)
queue.add(0, [0, start, []])
seen = []
loop do
  steps, pos, keys_held = queue.shift
  p [:pathfind, steps, keys_held.size, seen.size]

  next if seen.include?(keys_held)
  seen << keys_held

  if keys_held.sort == keys
    puts steps
    break
  end

  (keys - keys_held).each do |target|
    dest = map.key(target)
    dist, doors = distances[[pos, dest]]
    next unless dist
    next unless doors.sort == (doors & keys_held).sort
    new_steps = steps + dist
    new_keys = (keys_held + [target]).sort
    queue.add(new_steps, [new_steps, dest, new_keys])
  end
end

__END__

# Some WIP thoughts for solving part 2


class ManhattanMap
  WALL = "#"
  PATH = "."

  def self.parse(input, wall_sym: WALL, path_sym: PATH)
    map = {}
    input.each_with_index do |row, y|
      row.split(//).each_with_index do |cell, x|
        next if cell == wall_sym # Skip walls, uninteresting
        map[[x, y]] = cell
      end
    end
    self.new(map, path_sym: path_sym)
  end

  def initialize(map, path_sym: PATH)
    @map = map
    @path_sym = path_sym
  end

  def as_distance_graph
    out = {}
    (@map.values.uniq - [@path_sym]).sort.each do |poi|
      out[poi] ||= {}

      cell = @map.key(poi)
      queue = PriorityDeque.new(:min)
      queue.add(0, [0, cell])
      seen = []
      loop do
        break if queue.empty?
        dist, cell = queue.shift
        dest = @map[cell]
        next unless dest
        seen << cell
        if dest == @path_sym || dest == poi
          # Queue neighbours
          x, y = cell
          dist += 1
          queue.add(dist, [dist, [x + 1, y]]) unless seen.include?([x + 1, y])
          queue.add(dist, [dist, [x - 1, y]]) unless seen.include?([x - 1, y])
          queue.add(dist, [dist, [x, y + 1]]) unless seen.include?([x, y + 1])
          queue.add(dist, [dist, [x, y - 1]]) unless seen.include?([x, y - 1])
        else
          out[poi][dest] ||= dist
        end
      end
    end
    out
  end

  def as_dot
    edges = []
    as_distance_graph.each do |src, maps|
      maps.each do |dst, distance|
        next if src < dst
        edges << "#{src} -- #{dst} [label=#{distance}]".gsub("@", "Start")
      end
    end
    "graph manhattan {\n#{edges.join("\n")}\n}\n"
  end

  def dijkstra(start, destinations, graph)
    q = []
    dist = {}
    prev = {}
    graph.keys.each do |v|
      dist[v] = 1_000_000
      prev[v] = nil
      q << v
    end
    dist[start] = 0

    while !q.empty?
      u = q.sort_by { |qq| dist[qq] }.first
      q.delete(u)
      graph[u].each do |v, len|
        alt = dist[u] + len
        if alt < dist[v]
          dist[v] = alt
          prev[v] = [prev[u], u].compact.join
        end
      end
    end
    [dist, prev]
  end

  def as_full_distance_graph(pois)
    partial = as_distance_graph
    matrix = {}
    pois.each do |start|
      next unless partial[start]
      dist, path = dijkstra(start, pois, partial)
      dist.each do |v, steps|
        matrix[[start, v]] = [steps, path[v]]
      end
    end
    matrix
  end
end

distances = ManhattanMap.parse(input).as_full_distance_graph(['@'] + ('a'..'z').to_a)
distances.delete_if do |k, _v|
  src, dst = k
  (
    src == dst || # No-op
    dst =~ /[A-Z]/  # Travel to door
  )
end
pp distances

exit

keys = distances.keys.select{ |k| k =~ /[a-z]/ }.sort
doors = distances.keys.select{ |k| k =~ /[A-Z]/ }.sort

queue = PriorityDeque.new
queue.add(0, [0, '@', []])
seen = []
loop do
  steps, pos, keys_held = queue.shift
  p [:pathfind, steps, pos, keys_held.size, seen.size, queue.size]

  next if seen.include?([pos, keys_held])
  seen << [pos, keys_held]

  if keys_held.sort == keys
    puts steps
    break
  end

  distances[pos].each do |target, distance|
    if target =~ /[A-Z]/
      # Skip locked door
      next unless keys_held.include?(target.downcase)
    end
    if target =~ /[a-z]/
      # Pick up new key
      new_keys = (keys_held + [target]).sort.uniq
    else
      new_keys = keys_held
    end
    new_steps = steps + distance
    queue.add(new_keys.size-new_steps, [new_steps, target, new_keys])
  end
end
