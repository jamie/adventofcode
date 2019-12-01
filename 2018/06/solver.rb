require "advent"
input = Advent.input(2018, 6)

points = input.map { |line| line.split(", ").map(&:to_i) }

xs = points.map(&:first).min..points.map(&:first).max
ys = points.map(&:last).min..points.map(&:last).max

# Part 1

grid = xs.map do |i|
  ys.map do |j|
    distances = points.map { |x, y| [(x - i).abs + (y - j).abs] }
    if distances.count(distances.min) > 1
      -1
    else
      distances.index(distances.min)
    end
  end
end

counts = grid.flatten.inject(Hash.new(0)) { |h, e| h[e] += 1; h }

# Remove anything touching an edge
grid.first.uniq.each { |i| counts.delete(i) }
grid.last.uniq.each { |i| counts.delete(i) }
grid.map(&:first).uniq.each { |i| counts.delete(i) }
grid.map(&:last).uniq.each { |i| counts.delete(i) }

puts counts.values.max

# Part 2

grid = xs.map do |i|
  ys.map do |j|
    points.map { |x, y| [(x - i).abs + (y - j).abs] }.inject(&:+).inject(&:+)
  end
end

puts grid.flatten.select { |e| e < 10_000 }.count
