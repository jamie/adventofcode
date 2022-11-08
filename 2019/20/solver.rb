require "advent"
require "astar"
input = Advent.input

xinput = <<~STR.split("\n")
               Z L X W       C                 
               Z P Q B       K                 
    ###########.#.#.#.#######.###############  
    #...#.......#.#.......#.#.......#.#.#...#  
    ###.#.#.#.#.#.#.#.###.#.#.#######.#.#.###  
    #.#...#.#.#...#.#.#...#...#...#.#.......#  
    #.###.#######.###.###.#.###.###.#.#######  
    #...#.......#.#...#...#.............#...#  
    #.#########.#######.#.#######.#######.###  
    #...#.#    F       R I       Z    #.#.#.#  
    #.###.#    D       E C       H    #.#.#.#  
    #.#...#                           #...#.#  
    #.###.#                           #.###.#  
    #.#....OA                       WB..#.#..ZH
    #.###.#                           #.#.#.#  
  CJ......#                           #.....#  
    #######                           #######  
    #.#....CK                         #......IC
    #.###.#                           #.###.#  
    #.....#                           #...#.#  
    ###.###                           #.#.#.#  
  XF....#.#                         RF..#.#.#  
    #####.#                           #######  
    #......CJ                       NM..#...#  
    ###.#.#                           #.###.#  
  RE....#.#                           #......RF
    ###.###        X   X       L      #.#.#.#  
    #.....#        F   Q       P      #.#.#.#  
    ###.###########.###.#######.#########.###  
    #.....#...#.....#.......#...#.....#.#...#  
    #####.#.###.#######.#######.###.###.#.#.#  
    #.......#.......#.#.#.#.#...#...#...#.#.#  
    #####.###.#####.#.#.#.#.###.###.#.###.###  
    #.......#.....#.#...#...............#...#  
    #############.#.#.###.###################  
                 A O F   N                     
                 A A D   M                     
STR

PATH = "."

points = {}
input[0..-2].each_with_index do |row, y|
  row[0..-2].size.times do |x|
    curr = input[y][x]
    down = input[y + 1][x]
    right = input[y][x + 1]

    if /[A-Z][A-Z]/.match?("#{curr}#{down}")
      key = "#{curr}#{down}"
      if y > 0 && input[y - 1][x] == PATH
        points[[x, y - 1]] = key
      elsif y < input.size && input[y + 2][x] == PATH
        points[[x, y + 2]] = key
      end

    elsif /[A-Z][A-Z]/.match?("#{curr}#{right}")
      key = "#{curr}#{right}"
      if x > 0 && input[y][x - 1] == PATH
        points[[x - 1, y]] = key
      elsif x < row.size && input[y][x + 2] == PATH
        points[[x + 2, y]] = key
      end

    end
  end
end

distances = {}
points.each do |startpoint, start|
  points.each do |goalpoint, goal|
    next if startpoint == goalpoint

    if start < goal
      path = astar_map(input, startpoint, goalpoint)
      next if path == NOPATH
      distance = path.size - 1
      distances[startpoint] ||= {}
      distances[startpoint][goalpoint] = distance
      distances[goalpoint] ||= {}
      distances[goalpoint][startpoint] = distance
    end
    if start == goal
      # Wormholes, baby
      distances[startpoint] ||= {}
      distances[startpoint][goalpoint] = 1
      distances[goalpoint] ||= {}
      distances[goalpoint][startpoint] = 1
    end
  end
end

# Part 1
start = points.key("AA")
goal = points.key("ZZ")
paths = [[[start], 0]]
seen = [start]

loop do
  path, distance = paths.sort_by(&:last).first

  if path[-1] == goal
    puts distance
    break
  end

  last = path.last
  distances[last].each do |point, cost|
    next if seen.include?(point)
    seen << point
    paths << [path + [point], distance + cost]
  end

  paths.delete([path, distance])
end

# pp distances

# Part 2, maze recursion!
start = points.key("AA") + [0]
goal = points.key("ZZ") + [0]
paths = [[[start], 0]]
seen = [start]

loop do
  break if paths.empty?

  path, distance = paths.sort_by { |path, distance|
    [
      path.last.last, # prioritize less recursion
      distance
    ]
  }.first

  if path[-1] == goal
    puts distance
    break
  end

  last = path.last
  distances[last[0..1]].each do |point, cost|
    x0, y0, z0 = last
    x, y = point

    if points[[x, y]].nil? || points[[x, y]] != points[[x0, y0]]
      # Names are different, same floor
      z = z0
    elsif x == 2 || y == 2 || y == input.size - 3 || x == input[0].size - 3
      # Destination is outside edge, so we went in
      z = z0 + 1
    else
      # Otherwise we went out
      z = z0 - 1
      # But we cannot go out from top level
      next if z0 == 0
    end

    # Skip backtracking
    next if seen.include?([x, y, z])
    seen << [x, y, z]

    next if path.include?([x, y, z])
    paths << [path + [[x, y, z]], distance + cost]
  end

  paths.delete([path, distance])
end
