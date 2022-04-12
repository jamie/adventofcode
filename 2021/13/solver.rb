require "advent"
input = Advent.input.join("\n")

# Part 1
marks, folds = input.split("\n\n")
dots = []
marks.split("\n").each do |mark|
  x, y = mark.split(",").map(&:to_i)
  dots << [x, y]
end

folds.split("\n").each.with_index do |fold, i|
  fold =~ /(x|y)=(\d+)/
  axis, midline = $1, $2.to_i
  dots = dots.map do |x, y|
    if axis == "x"
      [x < midline ? x : midline - (x - midline), y]
    else
      [x, y < midline ? y : midline - (y - midline)]
    end
  end

  dots.uniq!
  puts dots.size if i == 0 # Part 1
end

# Part 2
# Indexes by inspection
(0..5).each do |y|
  (0..38).each do |x|
    if dots.include?([x, y])
      print "#"
    else
      print " "
    end
  end
  puts
end
