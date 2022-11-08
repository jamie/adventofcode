require "advent"
input = Advent.input

inpxut = "target area: x=20..30, y=-10..-5"
target = input.scan(/x=([0-9-]+)..([0-9-]+), y=([0-9-]+)..([0-9-]+)/)[0].map(&:to_i)

# Part 1

def probe_y(initial_velocity, target)
  dx, dy = initial_velocity
  x, y = 0, 0
  y_max = y
  intercept = false
  while y > target[2]
    x += dx
    y += dy
    y_max = [y, y_max].max
    dx -= 1 if dx > 0
    dy -= 1
    intercept = true if (target[2]..target[3]).cover?(y)
  end
  y_max if intercept
end

max = 1.upto(-target[2]).map do |y|
  probe_y([0, y], target)
end.compact.max
puts max

# Part 2

def probe(initial_velocity, tx, ty)
  dx, dy = initial_velocity
  x, y = 0, 0

  intercept = false
  while x < tx.max && y > ty.min
    x += dx
    y += dy
    dx -= 1 if dx > 0
    dy -= 1
    intercept = true if tx.cover?(x) && ty.cover?(y)
  end
  intercept
end

tx = target[0]..target[1]
ty = target[2]..target[3]

hits = 1.upto(tx.max).flat_map do |x|
  ty.min.upto(-ty.min).map do |y|
    [x, y] if probe([x, y], tx, ty)
  end
end.compact.count
p hits
