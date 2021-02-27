require "advent"
require "node"
input = Advent.input
numbers = input.split(//).map(&:to_i)

def debug(list)
  initial = list.value
  loop do
    print list.value
    list = list.right
    break puts if list.value == initial
  end
end

def arrange(cups, iterations)
  (cups.size-1).times do |i|
    cups[i].right = cups[i+1]
    cups[i+1].left = cups[i]
  end
  cups[-1].right = cups[0]
  cups[0].left = cups[-1]

  lookup = {}
  cups.each {|cup| lookup[cup.value] = cup}

  current = cups[0]

  iterations.times do |i|
    selection = current.right
    selected = [
      0, # edge condition hack
      selection.value,
      selection.right.value,
      selection.right.right.value
    ]
    current.right = current.right.right.right.right
    current.right.left = current

    target = current.value - 1
    while selected.include?(target)
      target -= 1
      target = lookup.keys.max if target < 1
    end
    ptr = lookup[target]

    selection.right.right.right = ptr.right
    ptr.right.left = selection.right.right
    ptr.right = selection
    selection.left = ptr

    current = current.right
  end

  current = current.right while current.value != 1
end

# Part 1

cups = numbers.map{|num| Node.new(num) }

arrange(cups, 100)

current = cups[1] # with value of 1
8.times do
  current = current.right
  print current.value
end
puts

# Part 2

cups = numbers.map{|num| Node.new(num) }
10.upto(1_000_000).each do |num|
  cups << Node.new(num)
end

arrange(cups, 10_000_000)

current = cups[1] # with value of 1
puts current.right.value * current.right.right.value
