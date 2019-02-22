require "advent"
input = Advent.input(2018, 12)

initial_state = input[0].match(/state: (.*)/).captures[0]

patterns = input[2..33].map { |line|
  line.match(/(.....) => (.)/).captures
}.inject({}) { |h, e|
  k, v = e
  key = k.split(//).map { |kk| kk == "#" }
  h[key] = (v == "#")
  h
}

require "set"

state = Set.new
initial_state.split(//).each_with_index do |e, i|
  state.add(i) if e == "#"
end
warmup = 150

warmup.times do |j|
  puts state.sum if j == 20 # Part 1
  new_state = Set.new
  ((state.min - 2)..(state.max + 2)).each do |i|
    region = ((i - 2)..(i + 2)).map { |ii| state.include? ii }
    new_state.add(i) if patterns[region]
  end
  state = new_state
end

# Pattern converges and repeats around 125 iterations, moving
# one slot to the right each iteration thereafter

puts state.sum + (state.count * (50_000_000_000 - warmup)) # Part 2
