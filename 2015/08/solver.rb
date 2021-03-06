require "advent"
input = Advent.input

# Part 1
diff = 0
input.each do |line|
  diff += line.length - eval(line).length
end
puts diff

# Part 2
diff = 0
input.each do |line|
  diff += line.inspect.length - line.length
end
puts diff
