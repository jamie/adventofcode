require "advent"
input = Advent.input()

layers = input.scan(/.{150}/)

fewest_zeroes = layers.sort_by { |layer| layer.count("0") }.first
puts fewest_zeroes.count("1") * fewest_zeroes.count("2")

6.times do |row|
  25.times do |col|
    cell = layers.map { |layer| layer[col + 25 * row] }
    cell.shift while cell.first == "2"
    print cell[0] == "0" ? " " : "#"
  end
  puts
end
