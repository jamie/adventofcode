input = 3014387

elves = input.times.to_a

# adjust numbering
elves << elves.size
elves.shift

i = 0
while elves.size > 1
  elf = elves[i]

  # Ruby is _really_ not optimized for doing this with a stock array.
  # 44 minute runtime compared to <1sec on part 1.
  gone = elves.delete_at((i + elves.size/2).floor % elves.size)

  i += 1 if gone > elf
  i = 0 if i >= elves.size
end

puts elves.first
