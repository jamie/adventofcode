require "advent"
input = Advent.input(2015, 24)
boxes = input.map(&:to_i)

# Part 1
target_weight = boxes.sum / 3

num_boxes = 1
num_boxes += 1 while boxes[-num_boxes..-1].sum < target_weight
start_num_boxes = num_boxes

solutions = []
loop do
  boxes.combination(num_boxes).each do |group1|
    next unless group1.sum == target_weight

    left = (boxes - group1)
    next unless (start_num_boxes..(left.size - start_num_boxes)).any? do |num|
      left.combination(num).any? { |group2| group2.sum == target_weight }
    end
    solutions << group1
  end
  break if solutions.any?
  num_boxes += 1
end

puts solutions.map { |group| group.inject(&:*) }.min

# Part 2
target_weight = boxes.sum / 4

num_boxes = 1
num_boxes += 1 while boxes[-num_boxes..-1].sum < target_weight
start_num_boxes = num_boxes

solutions = []
loop do
  boxes.combination(num_boxes).each do |group1|
    next unless group1.sum == target_weight

    left = boxes - group1
    next unless (start_num_boxes..(left.size - start_num_boxes)).any? do |num|
      left.combination(num).any? do |group2|
        last = left - group2
        group2.sum == target_weight &&
        (start_num_boxes..(last.size - start_num_boxes)).any? do |num3|
          last.combination(num).any? { |group3| group3.sum == target_weight }
        end
      end
    end
    solutions << group1
  end
  break if solutions.any?
  num_boxes += 1
end

puts solutions.map { |group| group.inject(&:*) }.min
