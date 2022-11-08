require "advent"
input = Advent.input

def covering(values)
  (values.min - 1)..(values.max + 1)
end

def adjacent3(nodes, node)
  x, y, z = node
  DIRS3D.select { |dx, dy, dz|
    nodes[[x + dx, y + dy, z + dz]]
  }.count
end

ACTIVE = "#"
INACTIVE = "."

active = {}
input.each.with_index do |row, y|
  row.each_char.with_index do |char, x|
    active[[x, y, 0]] = true if char == ACTIVE
  end
end

6.times do
  old, active = active, {}

  covering(old.keys.transpose[0]).each do |x|
    covering(old.keys.transpose[1]).each do |y|
      covering(old.keys.transpose[2]).each do |z|
        current = [x, y, z]
        neighbours = adjacent3(old, current)
        if neighbours == 3 || (neighbours == 2 && old[current])
          active[current] = true
        end
      end
    end
  end
end

puts active.size

## Part 2

# NB: This nested hash-based version is _much_
#     faster than the above flat hash.

def adjacent4(nodes, node)
  x, y, z, w = node
  DIRS4D.select { |dx, dy, dz, dw|
    nodes.dig(x + dx, y + dy, z + dz, w + dw)
  }.count
end

active = {}
input.each.with_index do |row, y|
  row.each_char.with_index do |char, x|
    z = w = 0
    active[x] ||= {}
    active[x][y] ||= {}
    active[x][y][z] ||= {}
    active[x][y][z][w] = true if char == ACTIVE
  end
end

wvals = []
6.times do
  old, active = active, {}

  xkeys, xvals = old.keys, old.values
  ykeys, yvals = xvals.map(&:keys).flatten, xvals.map(&:values).flatten
  zkeys, zvals = yvals.map(&:keys).flatten, yvals.map(&:values).flatten
  wkeys, wvals = zvals.map(&:keys).flatten, zvals.map(&:values).flatten

  covering(xkeys).each do |x|
    covering(ykeys).each do |y|
      covering(zkeys).each do |z|
        covering(wkeys).each do |w|
          active[x] ||= {}
          active[x][y] ||= {}
          active[x][y][z] ||= {}

          current = [x, y, z, w]
          neighbours = adjacent4(old, current)
          if neighbours == 3 || (neighbours == 2 && old.dig(*current))
            active[x][y][z][w] = true
          end
        end
      end
    end
  end

  # Argh, gotta recompute to get proper wvals for final output
  xkeys, xvals = active.keys, active.values
  ykeys, yvals = xvals.map(&:keys).flatten, xvals.map(&:values).flatten
  zkeys, zvals = yvals.map(&:keys).flatten, yvals.map(&:values).flatten
  wkeys, wvals = zvals.map(&:keys).flatten, zvals.map(&:values).flatten
end

puts wvals.size
