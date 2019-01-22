boxes = File.readlines('input').map(&:to_i)

def sum(ary)
  ary.inject(&:+)
end  
def qe(ary)
  ary.inject(&:*)
end

target_weight = sum(boxes) / 3

num_boxes = 1
num_boxes += 1 while sum(boxes[(boxes.size-num_boxes)..-1]) < target_weight
start_num_boxes = num_boxes

solutions = []
loop do
  boxes.combination(num_boxes).each do |group1|
    next unless sum(group1) == target_weight
    
    left = (boxes-group1)
    next unless (start_num_boxes..(left.size-start_num_boxes)).any? do |num|
      left.combination(num).any? { |group2| sum(group2) == target_weight }
    end
    solutions << group1
  end
  break if solutions.any?
  num_boxes += 1
end

puts solutions.map{|group| qe(group) }.min
boxes = File.readlines('input').map(&:to_i)

def sum(ary)
  ary.inject(&:+)
end  
def qe(ary)
  ary.inject(&:*)
end

target_weight = sum(boxes) / 4

num_boxes = 1
num_boxes += 1 while sum(boxes[(boxes.size-num_boxes)..-1]) < target_weight
start_num_boxes = num_boxes

solutions = []
loop do
  boxes.combination(num_boxes).each do |group1|
    next unless sum(group1) == target_weight
    
    left = boxes - group1
    next unless (start_num_boxes..(left.size-start_num_boxes)).any? do |num|
      left.combination(num).any? { |group2|
        last = left - group2
        sum(group2) == target_weight &&
        (start_num_boxes..(last.size-start_num_boxes)).any? do |num3|
          last.combination(num).any? { |group3| sum(group3) == target_weight }
        end
      }
    end
    solutions << group1
  end
  break if solutions.any?
  num_boxes += 1
end

puts solutions.map{|group| qe(group) }.min
