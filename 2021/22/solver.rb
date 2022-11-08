require "advent"
input = Advent.input

commands = input.map do |line|
  line =~ /(on|off) x=(.*),y=(.*),z=(.*)/
  op, xs, ys, zs = Regexp.last_match.captures
  xs = Range.new(*xs.split("..").map(&:to_i))
  ys = Range.new(*ys.split("..").map(&:to_i))
  zs = Range.new(*zs.split("..").map(&:to_i))
  [op, xs, ys, zs]
end

# Part 1

class Range
  def intersection(other)
    return nil if self.end < other.begin || other.end < self.begin
    [self.begin, other.begin].max..[self.end, other.end].min
  end
  alias_method :&, :intersection
end

cubes = {}
region = -50..50

commands.each do |op, xs, ys, zs|
  (xs & region || []).each do |x|
    (ys & region || []).each do |y|
      (zs & region || []).each do |z|
        cubes[[x, y, z]] = true if op == "on"
        cubes[[x, y, z]] = false if op == "off"
      end
    end
  end
end

puts cubes.values.select { |x| x }.size

# Part 2

class CubicRegion
  attr_reader :xs, :ys, :zs

  def initialize(xs, ys, zs)
    @xs = xs
    @ys = ys
    @zs = zs
  end

  def subdivide(x, y, z)
    subregions = [self]
    if xs.cover?(x)
      subregions = subregions.flat_map do |region|
        [
          CubicRegion.new(xs.begin...x, ys, zs),
          CubicRegion.new(x..xs.end, ys, zs)
        ]
      end
    end
    if ys.cover?(y)
      subregions = subregions.flat_map do |region|
        [
          CubicRegion.new(xs, ys.begin...y, zs),
          CubicRegion.new(xs, y..ys.end, zs)
        ]
      end
    end
    if zs.cover?(z)
      subregions = subregions.flat_map do |region|
        [
          CubicRegion.new(xs, ys, zs.begin...z),
          CubicRegion.new(xs, ys, z..zs.end)
        ]
      end
    end
    subregions
  end
end
