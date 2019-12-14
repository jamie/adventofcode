require "advent"
input = Advent.input()

class Point < Struct.new(:x, :y, :z)
  def distance_to(other)
    [x - other.x, y - other.y, z - other.z].map(&:abs).sum
  end
end

class Nanobot < Struct.new(:x, :y, :z, :r)
  def distance_to(other)
    [x - other.x, y - other.y, z - other.z].map(&:abs).sum
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
puts bots.select { |bot| strongest.in_range?(bot) }.size

# Part 2
PStack = PriorityDeque

class Region < Struct.new(:xmin, :xmax, :ymin, :ymax, :zmin, :zmax)
  def coverage(nanobots)
    nanobots.select { |bot| reachable?(bot) }.size
  end

  def reachable?(bot)
    distance = 0
    if bot.x < xmin
      distance += (xmin - bot.x)
    elsif bot.x > xmax
      distance += (bot.x - xmax)
    end
    if bot.y < ymin
      distance += (ymin - bot.y)
    elsif bot.y > ymax
      distance += (bot.y - ymax)
    end
    if bot.z < zmin
      distance += (zmin - bot.z)
    elsif bot.z > zmax
      distance += (bot.z - zmax)
    end
    distance <= bot.r
  end

  def point?
    xmin == xmax ||
    ymin == ymax ||
    zmin == zmax
  end

  def invalid?
    xmin > xmax ||
    ymin > ymax ||
    zmin > zmax
  end

  def subdivisions
    # eight of 'em
    xmid = (xmin + xmax) / 2
    ymid = (ymin + ymax) / 2
    zmid = (zmin + zmax) / 2
    [
      Region.new(xmin, xmid, ymin, ymid, zmin, zmid),
      Region.new(xmid + 1, xmax, ymin, ymid, zmin, zmid),
      Region.new(xmin, xmid, ymid + 1, ymax, zmin, zmid),
      Region.new(xmid + 1, xmax, ymid + 1, ymax, zmin, zmid),
      Region.new(xmin, xmid, ymin, ymid, zmid + 1, zmax),
      Region.new(xmid + 1, xmax, ymin, ymid, zmid + 1, zmax),
      Region.new(xmin, xmid, ymid + 1, ymax, zmid + 1, zmax),
      Region.new(xmid + 1, xmax, ymid + 1, ymax, zmid + 1, zmax),
    ].reject(&:invalid?)
  end

  def volume
    ((xmax - xmin + 1) * (ymax - ymin + 1) * (zmax - zmin + 1))
  end

  def size
    volume.to_s.size
  end

  def midpoint
    Point.new(
      (xmin + xmax) / 2,
      (ymin + ymax) / 2,
      (zmin + zmax) / 2,
    )
  end
end

xs = bots.map(&:x)
ys = bots.map(&:y)
zs = bots.map(&:z)
universe = Region.new(xs.min, xs.max, ys.min, ys.max, zs.min, zs.max)

search = PStack.new
search.add(universe.coverage(bots), universe)

n = 0
findings = []
coverage = nil
loop do
  region = search.pop

  if region.volume == 1
    cov = region.coverage(bots)
    coverage ||= cov
    if cov < coverage
      break
    elsif cov == coverage
      findings << region
    end
    next
  end

  region.subdivisions.each do |subregion|
    search.add(subregion.coverage(bots), subregion)
  end
end

origin = Point.new(0, 0, 0)
pp findings.sort_by { |region| region.midpoint.distance_to(origin) }.first.midpoint.distance_to(origin)
