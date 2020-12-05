require "advent"
input = Advent.input

# Part 1
seats = input.map do |line|
  rx, ry = 0,127
  line[0...7].each_char do |char|
    if char == 'F'
      ry = (rx + ry) / 2
    else
      rx = (rx + ry) / 2 + 1
    end
  end
  sx, sy = 0,7
  line[7...10].each_char do |char|
    if char == 'L'
      sy = (sx + sy) / 2
    else
      sx = (sx + sy) / 2 + 1
    end
  end
  id = rx * 8 + sx
end

puts seats.max

puts ((seats.min)..(seats.max)).to_a - seats
