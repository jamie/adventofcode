require 'advent'
input = Advent.input(2017, 11)[0]
steps = input.split(",")

# Cube coords, thanks redblobgames
class C < Struct.new(:x, :y, :z)
  def +(other)
    self.x += other.x
    self.y += other.y
    self.z += other.z
    self
  end
  def magnitude
    [x, y, z].map(&:abs).max
  end
end

tr = {
  'n'  => C.new( 0,  1, -1),
  'ne' => C.new( 1,  0, -1),
  'se' => C.new( 1, -1,  0),
  's'  => C.new( 0, -1,  1),
  'sw' => C.new(-1,  0,  1),
  'nw' => C.new(-1,  1,  0),
}

pos = C.new(0, 0, 0)
distances = []
steps.each do |dir|
  pos += tr[dir]
  distances << pos.magnitude
end
puts distances.last
puts distances.max
