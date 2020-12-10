require "advent"
input = Advent.input

containers = {}
input.each do |line| 
  container, contents = line.split(' bags contain ')
  containers[container] = []

  contents = contents.split(/ bags?[,.]/)
  if contents == ['no other']
    # NOP
  else
    contents.each do |content|
      count, kind = content.split(' ', 2)
      containers[container] << [count, kind]
    end
  end
end

# Part 1

def dig_for(containers, bag, target)
  return true if bag == target
  containers[bag].detect do |count, sub_bag|
    dig_for(containers, sub_bag, target)
  end
end

matching = 0
containers.keys.each do |root|
  next if root == 'shiny gold'
  if dig_for(containers, root, 'shiny gold')
    matching += 1
  end
end
puts matching

# Part 2

def count_content(containers, bag)
  @memo ||= {}
  return @memo[bag] if @memo[bag]

  if containers[bag].empty?
    # NOP
    content = 1
  else
    sub_bags = containers[bag]
    content = sub_bags.map do |count, sub_bag|
      count.to_i * count_content(containers, sub_bag)
    end.sum + 1
  end
  @memo[bag] = content
  content
end

puts count_content(containers, 'shiny gold') - 1
