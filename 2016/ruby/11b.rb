require "advent"
# input = Advent.input() # Manually parsed
require "set"

class Elevator
  attr_reader :queue, :input, :seen

  def initialize(gens, micros)
    @seen = Set.new
    @queue = PriorityDeque.new

    input = [0, 1, gens, micros]
    queue.add(score(*input), input)
  end

  def run
    loop do
      steps, *state = queue.pop

      next if seen.include?(state)

      seen.add(state)

      # End if all gens + micros are on floor 4
      return steps if state[1..2].flatten.uniq == [4]

      search(steps, *state)
    end
  end

  def search(steps, elevator, gens, micros)
    movable_gens = gens.each_index.select { |i| gens[i] == elevator }
    movable_micros = micros.each_index.select { |i| micros[i] == elevator }

    [elevator + 1, elevator - 1].each do |new_elevator|
      next unless (1..4).cover?(new_elevator)
      next if (1..new_elevator).all? { |floor| ((gens + micros) & [floor]).empty? }

      state = [steps + 1, new_elevator, gens, micros]

      movable_gens.product(movable_gens).each do |gen_id1, gen_id2|
        enqueue(*state, gen_id1: gen_id1, gen_id2: gen_id2)
      end
      movable_micros.product(movable_micros).each do |mic_id1, mic_id2|
        enqueue(*state, mic_id1: mic_id1, mic_id2: mic_id2)
      end
      movable_gens.product(movable_micros).each do |gen_id1, mic_id1|
        enqueue(*state, gen_id1: gen_id1, mic_id1: mic_id1)
      end
    end
  end

  private

  def valid?(_steps, _elevator, gens, micros)
    micros.size.times do |i|
      floor = micros[i]
      return false if gens.include?(floor) && gens[i] != floor
    end
    true
  end

  def score(steps, _elevator, gens, micros)
    # Prioritize by total distance to goal
    -(steps + steps + (gens + micros).map { |floor| 4 - floor }.sum)
  end

  def enqueue(steps, elevator, gens, micros, gen_id1: nil, gen_id2: nil, mic_id1: nil, mic_id2: nil)
    if gen_id1
      gens = gens.dup
      gens[gen_id1] = elevator
      gens[gen_id2] = elevator if gen_id2
    end
    if mic_id1
      micros = micros.dup
      micros[mic_id1] = elevator
      micros[mic_id2] = elevator if mic_id2
    end

    state = [steps, elevator, gens, micros]
    queue.add(score(*state), state) if valid?(*state)
  end
end

# # Example
# puts Elevator.new(
#   [2, 3], # H, L
#   [1, 1]
# ).run

# Part 1
puts Elevator.new(
  [1, 1, 2, 2, 2], # S P T R C
  [1, 1, 3, 2, 2]
).run

# Part 2
exit
puts Elevator.new(
  [1, 1, 2, 2, 2, 1, 1], # S P T R C E D
  [1, 1, 3, 2, 2, 1, 1]
).run
