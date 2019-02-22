require "advent"
input = Advent.input(2017, 20)

class Particle
  attr_reader :pos

  def initialize(description)
    p, v, a = description.split(", ")
    @pos = parse(p)
    @vel = parse(v)
    @acc = parse(a)
  end

  def parse(str)
    str =~ /<(.*)>/
    $1.split(",").map(&:to_i)
  end

  def distance_0
    @pos.map(&:abs).inject(&:+)
  end

  def step
    @vel[0] += @acc[0]
    @vel[1] += @acc[1]
    @vel[2] += @acc[2]

    @pos[0] += @vel[0]
    @pos[1] += @vel[1]
    @pos[2] += @vel[2]
  end
end

# Part 1
swarm = input.map { |line| Particle.new(line) }
500.times do
  swarm.each(&:step)
end
distances = swarm.map(&:distance_0)
puts distances.index(distances.min)

# Part 2
swarm = input.map { |line| Particle.new(line) }
50.times do
  swarm.each(&:step)
  swarm.group_by(&:pos).each do |pos, particles|
    if particles.size > 1
      swarm -= particles
    end
  end
end
puts swarm.size
