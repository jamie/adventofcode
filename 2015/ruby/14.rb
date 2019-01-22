require 'advent'
input = Advent.input(2015, 14)

TIME = 2503

Reindeer = Struct.new(:name, :speed, :endurance, :recovery, :location, :points) do
  attr_accessor :activity
  def initialize(*)
    super
    self.activity = [:fly] * endurance + [:rest] * recovery
  end

  def travel!
    self.location += speed if activity[0] == :fly
    activity << activity.shift
  end

  def score!
    self.points += 1
  end
end

reindeer = input.map do |line|
  line =~ /(.*) can fly (.*) km\/s for (.*) seconds, but then must rest for (.*) seconds./
  Reindeer.new($1, $2.to_i, $3.to_i, $4.to_i, 0, 0)
end

TIME.times do
  reindeer.each(&:travel!)
  scoring_location = reindeer.map(&:location).max
  reindeer.select{|deer| deer.location == scoring_location}.each(&:score!)
end

# Part 1
puts reindeer.map(&:location).max
# Part 2
puts reindeer.map(&:points).max
