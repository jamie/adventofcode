require "advent"
input = Advent.input.join("\n").split("\n\n")

# Part 1

def score(edge)
  [edge, edge.reverse].sort.first
end

tiles = {}
edges = {}
links = {}
input.each do |batch|
  rows = batch.split("\n")
  batch =~ /Tile (\d+):/
  id = $1.to_i

  pixels = rows[1..-1].map{|row| row.chomp}
  tiles[id] = pixels

  [
    pixels.first,
    pixels.last,
    pixels.map{|row| row[0]}.join,
    pixels.map{|row| row[-1]}.join,
  ].each do |edge|
    key = score(edge)
    edges[id] ||= []
    edges[id] << key
    links[key] ||= []
    links[key] << id
  end
end

# don't bother assembling, just find corner tiles
corners = edges.keys.select do |id|
  edges[id].select{|edge| links[edge].size == 1}.size == 2
end

puts corners.inject(&:*)

# Part 2

def rot_r(tile)
  tile.size.times.map do |y|
    tile.map{|row| row[y] }.join.reverse
  end
end

def permute(tile)
  yield tile
  yield tile.map(&:reverse)
  tile = rot_r(tile)
  yield tile
  yield tile.map(&:reverse)
  tile = rot_r(tile)
  yield tile
  yield tile.map(&:reverse)
  tile = rot_r(tile)
  yield tile
  yield tile.map(&:reverse)
end

start_tile = [corners.first, tiles[corners.first]]
loop do
  row = start_tile[1].first
  col = start_tile[1].map{ |r|r[0] }.join
  row_key = [row, row.reverse].sort.first
  col_key = [col, col.reverse].sort.first

  break if (links[row_key].size == 1 && links[col_key].size == 1)
  start_tile[1] = rot_r(start_tile[1])
end

# Line up tiles
grid = [[start_tile]]
12.times do |y|
  12.times do |x|
    next if x == 0 && y == 0

    if x > 0
      # going right
      old_id, old_tile = grid[y][x-1]
      right_edge = old_tile.map{ |r| r[-1] }.join
      matching_id = (links[score(right_edge)] - [old_id]).first
      new_tile = permute(tiles[matching_id]) do |tile|
        left_edge = tile.map{ |r| r[0] }.join
        break tile if left_edge == right_edge
      end
      grid[y][x] = [matching_id, new_tile]
      
    elsif y > 0
      # going down
      old_id, old_tile = grid[y-1][x]
      bottom_edge = old_tile[-1]
      matching_id = (links[score(bottom_edge)] - [old_id]).first
      new_tile = permute(tiles[matching_id]) do |tile|
        top_edge = tile[0]
        break tile if top_edge == bottom_edge
      end
      grid[y] = [[matching_id, new_tile]] # new row

    end
  end
end

# Sew up grid
image = grid.map do |row|
  row.map(&:last) # just tile image
    .map{|tile| tile[1..-2].map{|row| row[1..-2]}} # trim outline
    .transpose.map(&:join) # join rows
end.flatten # clean up

# Monster hunting
pattern = [
  [0,1],
  [1,2],
  [4,2],
  [5,1],
  [6,1],
  [7,2],
  [10,2],
  [11,1],
  [12,1],
  [13,2],
  [16,2],
  [17,1],
  [18,0],
  [18,1],
  [19,1],
]
waves = image.join.count("#")
permute(image) do |img|
  monster_count = 0
  0.upto(image.size - 3) do |y|
    0.upto(image.first.size - 20) do |x|
      if pattern.all?{|dx, dy| img[y+dy][x+dx] == "#"}
        pattern.each{|dx, dy| img[y+dy][x+dx] = "O"}
        monster_count += 1
      end
    end
  end
  if monster_count > 0
    puts img.join.count("#")
    break
  end
end
