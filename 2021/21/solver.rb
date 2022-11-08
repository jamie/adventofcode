require "advent"
input = Advent.input

starting_positions = input.map { |line|
  line =~ /: (\d+)/
  $1.to_i
}

# Part 1

class DeterministicDie
  attr_reader :rollcount

  def initialize
    @next = 1
    @rollcount = 0
  end

  def roll!
    @next.tap {
      @next += 1
      @next = 1 if @next > 100
      @rollcount += 1
    }
  end

  def roll3!
    roll! + roll! + roll!
  end
end

score = [0, 0]
positions = starting_positions.dup
active_player = 0
die = DeterministicDie.new

while score.max < 1000
  positions[active_player] += die.roll3!
  positions[active_player] -= 10 while positions[active_player] > 10
  score[active_player] += positions[active_player]
  active_player = 1 - active_player
  # break if score.max > 20
end
puts score.min * die.rollcount

# Part 2

# TODO: Needs some optimization, currently 9m27s runtime

dirac = {
  3 => 1, # 1,1,1
  4 => 3, # 1,1,2
  5 => 6, # 1,1,3; 1,2,2
  6 => 7, # 1,2,3; 2,2,2
  7 => 6, # 1,3,3; 2,2,3
  8 => 3, # 2,3,3
  9 => 1 # 3,3,3
}

universes = {
  ([0, 0, 0, 0] + starting_positions.dup) => 1
}
winners = [0, 0]

until universes.empty?
  u = universes.keys.sort.first
  universe_count = universes.delete(u)

  dirac.each do |roll, dirac_count|
    _, score1, score2, player, pos1, pos2 = u
    pos1 += roll
    pos1 -= 10 while pos1 > 10
    score1 += pos1

    if score1 >= 21
      winners[player] += universe_count * dirac_count
    else
      u_ = [
        score1 + score2, # Priority
        score2,
        score1,
        1 - player,
        pos2,
        pos1
      ] # swap player order
      universes[u_] ||= 0
      universes[u_] += universe_count * dirac_count
    end
  end
  # p [universes.size, u.first, winners] if rand(1000) == 35
end

puts winners.max
