require "advent"
input = Advent.input

tiles = input.map { |line|
  out = []
  dirs = line.split(//)
  while dirs.any?
    if dirs[0] == 'n' || dirs[0] == 's'
      dirs.unshift(dirs.shift + dirs.shift)
    end
    out << dirs.shift
  end
  out
}

targets = tiles.map { |dirs|
  loop do
    changed = false
    # normalize corners
    [
      # remove direct opposites
      ['e', 'w', nil],
      ['ne', 'sw', nil],
      ['se', 'nw', nil],
      # normalize corners
      ['ne', 'se', 'e'],
      ['nw', 'sw', 'w'],
      ['nw', 'e', 'ne'],
      ['ne', 'w', 'nw'],
      ['sw', 'e', 'se'],
      ['se', 'w', 'sw'],
    ].each do |move1, move2, effective_move|
      if dirs.include?(move1) && dirs.include?(move2)
        dirs.delete_at(dirs.index(move1))
        dirs.delete_at(dirs.index(move2))
        dirs << effective_move if effective_move
        changed = true
      end
    end
    break if !changed
  end

  dirs.sort
}

duplicates = targets.select {|dirs| targets.count(dirs) == 2}
targets -= duplicates
puts targets.size

# Part 2

# Normalize directions to q,r coords
# As always, thank you https://www.redblobgames.com/grids/hexagons/
grid = {}
targets.each { |dirs|
  q, r = 0, 0

  dirs.each do |dir|
    case dir
    when 'e'; q += 1
    when 'w'; q -= 1
    when 'nw'; r -= 1
    when 'se'; r += 1
    when 'ne'; q += 1; r -= 1
    when 'sw'; q -= 1; r += 1
    end
  end

  grid[[q, r]] = true
}

100.times do |i|
  newgrid = {}

  q_range = (grid.keys.map(&:first).min-1)..(grid.keys.map(&:first).max+1)
  r_range = (grid.keys.map(&:last).min-1)..(grid.keys.map(&:last).max+1)

  q_range.each do |q|
    r_range.each do |r|
      adj = HEXDIRS.count do |dq, dr|
        grid[[q+dq, r+dr]]
      end
      if adj == 2 || (adj == 1 && grid.include?([q,r]))
        newgrid[[q, r]] = true
      end
    end
  end

  grid = newgrid
end

puts grid.size
