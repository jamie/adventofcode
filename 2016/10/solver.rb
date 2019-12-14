require "advent"
input = Advent.input()

# Part 1
transitions = {}
inputs = []
bots = Hash.new { |h, k| h[k] = [] }

input.each do |line|
  case line
  when /value (.*) goes to (.*)/
    inputs << [Regexp.last_match(2), Regexp.last_match(1).to_i]
  when /(.*) gives low to (.*) and high to (.*)/
    transitions[Regexp.last_match(1)] = [Regexp.last_match(2), Regexp.last_match(3)]
  end
end

inputs.each do |bot, value|
  bots[bot] << value

  restart = true
  while restart
    restart = false
    bots.dup.each do |bbot, chips|
      if chips.size > 1
        puts bbot if chips.sort == [17, 61]

        low_to, high_to = transitions[bbot]
        bots[low_to] << chips.min
        bots[high_to] << chips.max
        bots[bbot] = [] # reset
        restart = true
      end
    end
  end
end

# Part 2
transitions = {}
inputs = []
bots = Hash.new { |h, k| h[k] = [] }

input.each do |line|
  case line
  when /value (.*) goes to (.*)/
    inputs << [Regexp.last_match(2), Regexp.last_match(1).to_i]
  when /(.*) gives low to (.*) and high to (.*)/
    transitions[Regexp.last_match(1)] = [Regexp.last_match(2), Regexp.last_match(3)]
  end
end

inputs.each do |bot, value|
  bots[bot] << value

  restart = true
  while restart
    restart = false
    bots.dup.each do |bbot, chips|
      if chips.size > 1
        low_to, high_to = transitions[bbot]
        bots[low_to] << chips.min
        bots[high_to] << chips.max
        bots[bbot] = [] # reset
        restart = true
      end
    end
  end
end

puts [bots["output 0"], bots["output 1"], [bots["output 2"]]].flatten.inject(&:*)
