# row 2978, column 3083.

row = col = 1

value = 20151125

while row < 2978
  row.times { value = (value * 252533) % 33554393 }
  row += 1
end

while col < 3083
  (row+col).times { value = (value * 252533) % 33554393 }
  col += 1
end

puts value
