input = 3014387

elves = input.times.to_a

# adjust numbering
elves << elves.size
elves.shift

while elves.size > 1
  shift = elves.size%2 == 1
  elves = elves.map.with_index(0){|e, i| e if i%2 == 0}.compact
  elves.shift if elves.size > 1 && shift
end

puts elves.first
