require "advent"
input = Advent.input

inpxut = <<END.split("\n")
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
END

# Part 1

priorities = input.map do |line|
  len = line.size / 2
  left = line[0...len].split("")
  right = line[len..].split("")
  duplicate = (left & right).first
  byte = duplicate.bytes.first

  if duplicate >= "a"
    byte - 96
  else
    byte - 64 + 26
  end
end
puts priorities.sum

# Part 2

badges = input.each_slice(3).map do |elves|
  badge = elves.map{_1.split("")}.inject(&:&)[0]
  byte = badge.bytes.first

  if badge >= "a"
    byte - 96
  else
    byte - 64 + 26
  end
end
puts badges.sum
