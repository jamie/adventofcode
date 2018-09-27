SEED = 1358
TARGET = [31, 39]

def wall?(x, y)
  id = x*x + 3*x + 2*x*y + y + y*y + SEED
  ones = id.to_s(2).split(//).select{|e|e=='1'}.size
  ones % 2 == 1
end

seen = [[1,1]]
search = [[1,1,0]]

while search.any? do
  x, y, steps = search.shift
  next if steps == 50
  [ [0,1],
    [1,0],
    [0,-1],
    [-1,0]
  ].each do |dx, dy|
    xx, yy = x+dx, y+dy

    next if xx < 0 || yy < 0
    next if wall?(xx,yy)
    next if seen.include?([xx,yy])
    seen << [xx, yy]
    search << [xx, yy, steps+1]
  end
end

puts seen.size
