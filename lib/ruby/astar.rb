require 'set'

WALL = "#".freeze
EMPTY = " ".freeze
NOPATH = "No Path"

def manhattan(a, b)
  [a,b].transpose.map{|x,y| (x-y).abs }.sum
end

def astar_map(map, start, goal)
  openset = Set.new
  openset << start
  came_from = {}

  gscore = Hash.new { 10**10 }
  fscore = Hash.new { 10**10 }
  
  gscore[start] = 0
  fscore[start] = manhattan(start, goal)
  
  loop do
    return NOPATH if openset.empty?
  
    curr = openset.sort_by{|x| fscore[x]}.first
    if curr == goal
      path = [curr]
      while came_from[curr]
        curr = came_from[curr]
        path << curr
      end
      return path.reverse
    end

    openset.delete(curr)
    
    [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |delta|
      x,y = neighbour = [curr, delta].transpose.map(&:sum)
      next if x < 0 || y < 0
      next unless map[y] && map[y][x]
      next if map[y][x] == WALL
      next if map[y][x] == EMPTY
      
      g = gscore[curr] + 1
      if g < gscore[neighbour]
        came_from[neighbour] = curr
        gscore[neighbour] = g
        fscore[neighbour] = g + manhattan(neighbour, goal)
        openset << neighbour
      end
    end
  end
end
