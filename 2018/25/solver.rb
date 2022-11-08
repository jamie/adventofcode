if RUBY_VERSION < "2.6.0"
  puts "Requires Array#union from ruby 2.6+"
  exit
end

require "advent"
input = Advent.input

Point = Struct.new(:x, :y, :z, :t) do
  def distance(other)
    [
      x - other.x,
      y - other.y,
      z - other.z,
      t - other.t
    ].sum(&:abs)
  end
end
points = input.map do |line|
  Point.new(*line.split(",").map(&:to_i))
end

# Part 1
constellations = []

points.each do |point|
  candidates = []
  constellations.each do |cons|
    if cons.any? { |cpoint| cpoint.distance(point) <= 3 }
      candidates << cons
    end
  end
  case candidates.size
  when 0
    constellations << [point]
  when 1
    candidates.first << point
  when 2..9999
    constellations -= candidates
    supercons = candidates.inject(&:union)
    supercons << point
    constellations << supercons
  end
end

puts constellations.size
