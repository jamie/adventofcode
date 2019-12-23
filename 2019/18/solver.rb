require "advent"
input = Advent.input

require "priority_deque"

inpxut = <<STR.split("\n")
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

xinput = <<STR.split("\n")
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
