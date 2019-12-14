require "advent"
input = Advent.input()
target_row, target_col = input.match(/row (\d+), column (\d+)/).captures.map(&:to_i)

row = col = 1

value = 20151125

while row < target_row
  row.times { value = (value * 252533) % 33554393 }
  row += 1
end

while col < target_col
  (row + col).times { value = (value * 252533) % 33554393 }
  col += 1
end

puts value
