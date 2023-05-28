require "advent"
input = Advent.input

xinput = <<~END.split("\n")
      [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
END

# Part 1

setup, _, commands = input.chunk { _1 == "" }.map(&:last)
columns = setup.pop
# Find the indexes of integers in the columns string
count = columns.split(/ +/).map(&:to_i).max

stacks = [[]]
setup.reverse_each do |row|
  1.upto(count) do |i|
    value = row[i * 4 - 3]
    next if value == " "
    stacks[i] ||= []
    stacks[i] << value
  end
end
stacks.map(&:compact!)

commands.each do |cmd|
  count, source, dest = cmd.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i)
  count.times { stacks[dest] << stacks[source].pop }
end

puts stacks.map(&:last).join("")

# Part 2

setup, _, commands = input.chunk { _1 == "" }.map(&:last)
columns = setup.pop
# Find the indexes of integers in the columns string
count = columns.split(/ +/).map(&:to_i).max

stacks = [[]]
setup.reverse_each do |row|
  1.upto(count) do |i|
    value = row[i * 4 - 3]
    next if value == " "
    stacks[i] ||= []
    stacks[i] << value
  end
end
stacks.map(&:compact!)

commands.each do |cmd|
  count, source, dest = cmd.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i)
  stacks[dest] += stacks[source][-count..]
  stacks[source] = stacks[source][0...-count]
end

puts stacks.map(&:last).join("")
