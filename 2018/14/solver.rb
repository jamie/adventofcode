require "advent"
input = Advent.input(:to_i)

recipes = [3, 7]
elf1 = 0
elf2 = 1

# Part 1

while recipes.size < input + 10
  score = recipes[elf1] + recipes[elf2]
  recipes << 1 if score > 9
  recipes << score % 10
  elf1 = (elf1 + 1 + recipes[elf1]) % recipes.size
  elf2 = (elf2 + 1 + recipes[elf2]) % recipes.size
end

puts recipes[input...(input + 10)].join

# Part 2

goal = input.to_s.split(//).map(&:to_i)
recent = recipes[-goal.size..-1]
loop do
  score = recipes[elf1] + recipes[elf2]

  if score > 9
    recipes << 1
    recent << 1
    recent.shift
    break if recent == goal
  end

  recipes << score % 10
  recent << score % 10
  recent.shift
  break if recent == goal

  elf1 = (elf1 + 1 + recipes[elf1]) % recipes.size
  elf2 = (elf2 + 1 + recipes[elf2]) % recipes.size
end
puts recipes.size - goal.size
