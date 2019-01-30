require 'advent'
# input = Advent.input(2016, 11) # Manually parsed

class Elevator
  attr_reader :queue, :input

  def initialize(nodes, input)
    @nodes = nodes
    @input = input
    @queue = {17 => [input]}
  end

  def run
    queue = {17 => [input]}

    seen = { input[1..-1] => 0 }
    current = nil

    while !queue.empty? do
      60.downto(1) do |i|
        if queue[i] && !queue[i].empty?
          current = queue[i].shift
          break
        end
      end
      steps, elevator, *state = current

      next unless valid?(state)

      if state.all?{|e| e == 4}
        return steps
      end

      [1, -1].each do |direction|
        new_elevator = elevator + direction
        next unless (1..4).include?(new_elevator)

        # Move one component
        state.each_with_index do |f, i|
          next unless f == elevator
          new_state = state.dup
          new_state[i] = new_elevator

          next if seen[[new_elevator] + new_state]
          enqueue(queue, steps+1, new_elevator, new_state)
          seen[[new_elevator] + new_state] = [elevator] + state
        end

        # Move two components
        state.each_with_index do |f, i|
          next unless f == elevator

          state.each_with_index do |f2, i2|
            next unless f2 == elevator
            next if i == i2

            new_state = state.dup
            new_state[i] = new_elevator
            new_state[i2] = new_elevator

            next if seen[[new_elevator] + new_state]
            enqueue(queue, steps+1, new_elevator, new_state)
            seen[[new_elevator] + new_state] = [elevator] + state
          end
        end
      end
    end
  end

private
  def valid?(state)
    floors = Hash[@nodes.zip(state)]
    floors.each do |node, floor|
      # microchip
      next if node =~ /G/
      next if floor == floors[node.tr('M','G')] # same floor as own generator, safe
      floors.each do |gen_node, gen_floor|
        # generator
        next if gen_node =~ /M/
        return false if node[0] != gen_node[0] && floor == gen_floor
      end
    end

    true
  end

  def score(steps, state)
    state.inject(&:+) - steps/2
  end

  def enqueue(queue, steps, elevator, state)
    queue[score(steps, state)] ||= []
    queue[score(steps, state)] << [steps, elevator] + state
  end
end


# Example
puts Elevator.new(
  %w(HG HM LG LM),
  [0, 1, 2, 1, 3, 1]
).run

# Part 1
puts Elevator.new(
  %w(SG SM PG PM TG TM RG RM CG CM),
  [0, 1, 1, 1, 1, 1, 2, 3, 2, 2, 2, 2]
).run

# Part 2
exit
puts Elevator.new(
  %w(SG SM PG PM TG TM RG RM CG CM EG EM DG DM),
  [0, 1, 1, 1, 1, 1, 2, 3, 2, 2, 2, 2, 1, 1, 1, 1]
).run
