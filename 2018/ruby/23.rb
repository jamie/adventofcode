require 'advent'
input = Advent.input(2018, 23)

class Point < Struct.new(:x, :y, :z)
end

class Nanobot < Struct.new(:x, :y, :z, :r)
  def distance_to(other)
    [x-other.x, y-other.y, z-other.z].map(&:abs).sum
  end

  def in_range?(other)
    distance_to(other) <= r
  end
end

bots = input.map do |line|
  Nanobot.new(*line.match(/pos=<(-?\d+),(-?\d+),(-?\d+)>, r=(\d+)/).captures.map(&:to_i))
end

# Part 1
strongest = bots.sort_by(&:r).last
puts bots.select{|bot| strongest.in_range?(bot) }.size

# Part 2
