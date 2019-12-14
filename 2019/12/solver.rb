require "advent"
input = Advent.input()

# Test inputs
inpxut = <<IN.split("\n")
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>
IN

ixnput = <<IN.split("\n")
<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>
IN

pairs = [0, 1, 2, 3].permutation(2).to_a.map(&:sort).uniq

# Part 1
points = input.map { |line| line.scan(/-?\d+/).map(&:to_i) }
velocity = input.map { [0, 0, 0] }

1000.times do
  # update velocity
  pairs.each do |i, j|
    3.times do |axis|
      diff = points[i][axis] <=> points[j][axis]
      velocity[i][axis] -= diff
      velocity[j][axis] += diff
    end
  end

  # update position
  4.times do |i|
    3.times do |axis|
      points[i][axis] += velocity[i][axis]
    end
  end
end

energy = 0
4.times do |i|
  energy += points[i].map(&:abs).inject(&:+) * velocity[i].map(&:abs).inject(&:+)
end
puts energy

# Part 2
points = input.map { |line| line.scan(/-?\d+/).map(&:to_i) }
velocity = input.map { [0, 0, 0] }

loops = [nil, nil, nil]

3.times do |axis|
  # Run each axis independently
  1_000_000.times do |n|
    # update velocity
    pairs.each do |i, j|
      diff = points[i][axis] <=> points[j][axis]
      velocity[i][axis] -= diff
      velocity[j][axis] += diff
    end

    # update position
    4.times do |i|
      points[i][axis] += velocity[i][axis]
    end

    # velocity all 0 is halfway through pendulum motion
    if velocity.all? { |v| v[axis] == 0 }
      loops[axis] = (n + 1) * 2
      break
    end
  end
end

puts loops[0].lcm(loops[1]).lcm(loops[2])
