require 'advent'
input = Advent.input(2018, 17)

grid = (['.' * 2000] * 2000).map(&:dup)

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
      grid[y][base] = '#'
    end
  else # line y=, x=
    xmin = [xmin, range.min].min
    xmax = [xmax, range.max].max
    ymax = [ymax, base].max
    range.each do |x|
      grid[base][x] = '#'
    end
  end
end


$grid = grid
def support?(y, x)
  %w(# ~).include?($grid[y][x])
end
def empty?(y,x)
  %w(.).include?($grid[y][x])
end

waters = [[0, 500]]
loop do
  # p [waters.size, waters.last(6)]
  break if waters.empty?
  y, x = waters.last

  # Record this as water
  grid[y][x] = '|' if grid[y][x] == '.'
  
  # Terminate
  if y > ymax || grid[y+1][x] == '|'
    waters.delete([y, x])
    next
  end

  waters << [y+1, x] if empty?(y+1, x)

  if support?(y+1, x)
    # Sitting on flat ground, or more water
    # check for solid ground leading to walls, if enclosed fill with water
    solid_left = x.downto(0) do |x2|
      break x2 if grid[y][x2] == '#'
      break false unless support?(y+1, x2)
      false
    end
    solid_right = x.upto(grid[y].size-1) do |x2|
      break x2 if grid[y][x2] == '#'
      break false unless support?(y+1, x2)
      false
    end
    if solid_left && solid_right
      ((solid_left+1)..(solid_right-1)).each do |x2|
        grid[y][x2] = '~'
      end
      waters.delete([y, x])
    end
  end

  # spread pressure sideways
  if support?(y+1, x) # supported below
    waters << [y, x-1] if empty?(y, x-1)
    waters << [y, x+1] if empty?(y, x+1)
    waters.delete([y, x])
  end
end

# puts grid.map.with_index{|row, i| row[xmin..xmax] + " #{i}"}[(ymin+1)..(ymax-1)]

# Adjust scan range for stuff that flows outside our bounds
# but definitely use them to slice for performance
xmin -= 1
xmax += 1

# Part 1
puts grid[ymin..ymax].map{|line|
  line[xmin..xmax].split(//)
}.flatten.select{|e| %w(| ~).include? e}.size

# Part 2
puts grid[ymin..ymax].map{|line|
  line[xmin..xmax].split(//)
}.flatten.select{|e| %w(~).include? e}.size
