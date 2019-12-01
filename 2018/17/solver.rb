require "advent"
input = Advent.input(2018, 17)

grid = ([["."] * 2000] * 2000).map(&:dup)

xmin = ymin = 2000
xmax = ymax = 0
input.each do |line|
  base, min, max = line.match(/.=(\d+), .=(\d+)..(\d+)/).captures.map(&:to_i)
  range = (min..max)
  if line =~ /^x/
    ymin = [ymin, range.min].min
    ymax = [ymax, range.max].max
    xmax = [xmax, base].max
    range.each do |y|
      grid[y][base] = "#"
    end
  else # line y=, x=
    xmin = [xmin, range.min].min
    xmax = [xmax, range.max].max
    ymax = [ymax, base].max
    range.each do |x|
      grid[base][x] = "#"
    end
  end
end
# Adjust scan range for stuff that flows outside our bounds
# but definitely use them to slice for performance
xmin -= 1
xmax += 1

def grid.wall?(y, x)
  %w(#).include?(self[y][x])
end

def grid.support?(y, x)
  %w(# ~).include?(self[y][x])
end

def grid.empty?(y, x)
  %w(.).include?(self[y][x])
end

def grid.set(y, x, val)
  self[y][x] = val
end

waters = [[0, 500]]
loop do
  # p [waters.size, waters.last(6)]
  break if waters.empty?
  y, x = waters.last

  # Record this as water
  grid.set(y, x, "|") if grid.empty?(y, x)

  # Terminate
  if y > ymax || grid[y + 1][x] == "|"
    waters.delete([y, x])
    next
  end

  waters << [y + 1, x] if grid.empty?(y + 1, x)

  if grid.support?(y + 1, x)
    # Sitting on flat ground, or more water
    # check for solid ground leading to walls, if enclosed fill with water
    solid_left = x.downto(0) do |x2|
      break x2 if grid.wall?(y, x2)
      break false unless grid.support?(y + 1, x2)
      false
    end
    solid_right = x.upto(grid[y].size - 1) do |x2|
      break x2 if grid.wall?(y, x2)
      break false unless grid.support?(y + 1, x2)
      false
    end
    if solid_left && solid_right
      ((solid_left + 1)..(solid_right - 1)).each do |x2|
        grid.set(y, x2, "~")
      end
      waters.delete([y, x])
    end
  end

  # spread pressure sideways
  if grid.support?(y + 1, x) # supported below
    waters << [y, x - 1] if grid.empty?(y, x - 1)
    waters << [y, x + 1] if grid.empty?(y, x + 1)
    waters.delete([y, x])
  end
end

# puts grid.map.with_index{|row, i| row[xmin..xmax] + " #{i}"}[(ymin+1)..(ymax-1)]

# Part 1
grid[ymin..ymax].map do |line|
  line[xmin..xmax]
end.flatten.select { |e| %w(| ~).include? e }.size.tap{|e| puts e }

# Part 2
grid[ymin..ymax].map do |line|
  line[xmin..xmax]
end.flatten.select { |e| %w(~).include? e }.size.tap{|e| puts e }
