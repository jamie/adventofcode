require "advent"
input = Advent.input

# Part 1
nice = 0

input.each do |string|
  if /[aeiou].*[aeiou].*[aeiou]/.match?(string)
    if /(.)\1/.match?(string)
      if !/ab|cd|pq|xy/.match?(string)
        nice += 1
      end
    end
  end
end

puts nice

# Part 2
nice = 0

input.each do |string|
  if /(..).*\1/.match?(string)
    if /(.).\1/.match?(string)
      nice += 1
    end
  end
end

puts nice
