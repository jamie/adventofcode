require "advent"
input = Advent.input

# Part 1
pos = [0, 0]
trees = 0
while (input[pos.last])
  line = input[pos.last]
  trees += 1 if line[pos.first % line.size] == '#'
  pos = [pos.first + 3, pos.last + 1]
end
puts trees

# Part 2
slopes = [[1, 1], [3,1], [5,1], [7,1], [1,2]]
all_trees = []
slopes.each do |x, y|
  pos = [0, 0]
  trees = 0
  while (input[pos.last])
    line = input[pos.last]
    trees += 1 if line[pos.first % line.size] == '#'
    pos = [pos.first + x, pos.last + y]
  end
  all_trees << trees
end
puts all_trees.inject(&:*)
