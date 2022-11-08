require "advent"
# input = Advent.input # Manually parsed

class Elevator
  attr_reader :queue, :input, :seen

  def initialize(nodes, input)
    @nodes = nodes
    @input = input
    @seen = {input[1..-1] => 0}
    @queue = {17 => [input]}
  end

  def run
    until queue.empty?
      steps, elevator, *state = pop_queue

      next unless valid?(state)

      # End State
      return steps if state.uniq == [4]

      [elevator + 1, elevator - 1].each do |new_elevator|
        next unless (1..4).include?(new_elevator)

        state.each_with_index do |f, i|
          next unless f == elevator
          # Move one component
          enqueue_move(state, steps, new_elevator, i)

          state.each_with_index do |f2, j|
            next unless f2 == elevator
            next if i == j
            # Move two components
            enqueue_move(state, steps, new_elevator, i, j)
          end
        end
      end

      # p [queue.values.map(&:size).inject(&:+), seen.size, steps, score(steps, state)] if rand(1000).zero?
    end
  end

  private

  def pop_queue
    65.downto(1) do |i|
      if !queue[i].nil? && !queue[i].empty?
        return queue[i].shift
      end
    end
  end

  def valid?(state)
    floors = @nodes.zip(state).to_h
    floors.each do |node, floor|
      # microchip
      next if /G/.match?(node)
      next if floor == floors[node.tr("M", "G")] # same floor as own generator, safe
      floors.each do |gen_node, gen_floor|
        # generator
        next if /M/.match?(gen_node)
        return false if node[0] != gen_node[0] && floor == gen_floor
      end
    end

    true
  end

  def score(steps, state)
    state.inject(&:+) - steps / 2
  end

  def enqueue_move(state, steps, new_elevator, i, j = nil)
    new_state = state.dup
    new_state[i] = new_elevator
    new_state[j] = new_elevator if j

    return if seen[[new_elevator] + new_state]
    enqueue(steps + 1, new_elevator, new_state)
    seen[[new_elevator] + new_state] = steps
  end

  def enqueue(steps, elevator, state)
    queue[score(steps, state)] ||= []
    queue[score(steps, state)] << [steps, elevator] + state
  end
end

# # Example
# puts Elevator.new(
#   %w(HG HM LG LM),
#   [0, 1, 2, 1, 3, 1]
# ).run

# Part 1
puts Elevator.new(
  %w[SG SM PG PM TG TM RG RM CG CM],
  [0, 1, 1, 1, 1, 1, 2, 3, 2, 2, 2, 2]
).run

# Part 2
exit
puts Elevator.new(
  %w[SG SM PG PM TG TM RG RM CG CM EG EM DG DM],
  [0, 1, 1, 1, 1, 1, 2, 3, 2, 2, 2, 2, 1, 1, 1, 1]
).run
