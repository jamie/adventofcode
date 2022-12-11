require "advent"
input = Advent.input

inpxut = <<STR.split("\n")
30373
25512
65332
33549
35390
STR

# Part 1

input.map!{_1.split("")}

ymin = 0
ymax = input.size-1
xmin = 0
xmax = input[0].size-1

seen = 0
input.each.with_index do |row, y|
  row.each.with_index do |tree, x|
    col = input.map{_1[x]}
    visible = false
    visible = true if x == 0 || y == 0 || x == xmax || y == ymax
    visible = true if row[0...x].all?{|n| n < tree}
    visible = true if row[(x+1)..xmax].all?{|n| n < tree}
    visible = true if col[0...y].all?{|n| n < tree}
    visible = true if col[(y+1)..ymax].all?{|n| n < tree}
    seen += 1 if visible
  end
end
puts seen

# Part 2

max_seen = 0
out = input.flat_map.with_index do |row, y|
  row.map.with_index do |tree, x|
    col = input.map{_1[x]}
    left = 0
    (x-1).downto(xmin) do |xx|
      break if xx < xmin
      left += 1
      break if row[xx] >= tree
    end
    right = 0
    (x+1).upto(xmax) do |xx|
      break if xx > xmax
      right += 1
      break if row[xx] >= tree
    end
    up = 0
    (y-1).downto(ymin) do |yy|
      break if yy < ymin
        up += 1
      break if col[yy] >= tree
    end
    down = 0
    (y+1).upto(ymax) do |yy|
      break if yy > ymax
      down += 1
      break if col[yy] >= tree
    end
    seen = left * right * up * down
    seen
  end
end
puts out.max

