require "advent"
input = Advent.input(2019, 12)

points = input.map{|line| line.scan(/-?\d+/).map(&:to_i)}
velocity = input.map{ [0, 0, 0] }

1000.times do
  # update velocity
  0.upto(2) do |i|
    (i+1).upto(3) do |j|
      0.upto(2) do |axis|
        diff = points[i][axis] <=> points[j][axis]
        velocity[i][axis] -= diff
        velocity[j][axis] += diff
      end
    end
  end

  # update position
  0.upto(3) do |i|
    0.upto(2) do |axis|
      points[i][axis] += velocity[i][axis]
    end
  end
end

energy = 0
0.upto(3) do |i|
  energy += points[i].map(&:abs).inject(&:+) * velocity[i].map(&:abs).inject(&:+)
end
puts energy

# Part 2
inxput = <<IN.split("\n")
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>
IN
points = input.map{|line| line.scan(/-?\d+/).map(&:to_i)}
velocity = input.map{ [0, 0, 0] }
state = nil
history = []

i = 0
loop do
  # update velocity
  diff = points[0][0] <=> points[1][0]
  velocity[0][0] -= diff
  velocity[1][0] += diff
  diff = points[0][1] <=> points[1][1]
  velocity[0][1] -= diff
  velocity[1][1] += diff
  diff = points[0][2] <=> points[1][2]
  velocity[0][2] -= diff
  velocity[1][2] += diff

  diff = points[0][0] <=> points[2][0]
  velocity[0][0] -= diff
  velocity[2][0] += diff
  diff = points[0][1] <=> points[2][1]
  velocity[0][1] -= diff
  velocity[2][1] += diff
  diff = points[0][2] <=> points[2][2]
  velocity[0][2] -= diff
  velocity[2][2] += diff

  diff = points[0][0] <=> points[3][0]
  velocity[0][0] -= diff
  velocity[3][0] += diff
  diff = points[0][1] <=> points[3][1]
  velocity[0][1] -= diff
  velocity[3][1] += diff
  diff = points[0][2] <=> points[3][2]
  velocity[0][2] -= diff
  velocity[3][2] += diff

  diff = points[1][0] <=> points[2][0]
  velocity[1][0] -= diff
  velocity[2][0] += diff
  diff = points[1][1] <=> points[2][1]
  velocity[1][1] -= diff
  velocity[2][1] += diff
  diff = points[1][2] <=> points[2][2]
  velocity[1][2] -= diff
  velocity[2][2] += diff

  diff = points[1][0] <=> points[3][0]
  velocity[1][0] -= diff
  velocity[3][0] += diff
  diff = points[1][1] <=> points[3][1]
  velocity[1][1] -= diff
  velocity[3][1] += diff
  diff = points[1][2] <=> points[3][2]
  velocity[1][2] -= diff
  velocity[3][2] += diff

  diff = points[2][0] <=> points[3][0]
  velocity[2][0] -= diff
  velocity[3][0] += diff
  diff = points[2][1] <=> points[3][1]
  velocity[2][1] -= diff
  velocity[3][1] += diff
  diff = points[2][2] <=> points[3][2]
  velocity[2][2] -= diff
  velocity[3][2] += diff

  # update position
  points[0][0] += velocity[0][0]
  points[0][1] += velocity[0][1]
  points[0][2] += velocity[0][2]
  points[1][0] += velocity[1][0]
  points[1][1] += velocity[1][1]
  points[1][2] += velocity[1][2]
  points[2][0] += velocity[2][0]
  points[2][1] += velocity[2][1]
  points[2][2] += velocity[2][2]
  points[3][0] += velocity[3][0]
  points[3][1] += velocity[3][1]
  points[3][2] += velocity[3][2]

  state = (points.flatten + velocity.flatten).join(',')
  break if history.include?(state)
  history.shift if i > 100
  history << state

  p i if i % 1_000_000 == 0

  i += 1
end

p state
puts i
