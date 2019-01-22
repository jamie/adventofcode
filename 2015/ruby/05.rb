require 'advent'
input = Advent.input(2015, 5)

# Part 1
nice = 0

input.each do |string|
  if string =~ /[aeiou].*[aeiou].*[aeiou]/
    if string =~ /(.)\1/
      if string !~ /ab|cd|pq|xy/
        nice += 1
      end
    end
  end
end

puts nice

# Part 2
nice = 0

input.each do |string|
  if string =~ /(..).*\1/
    if string =~ /(.).\1/
      nice += 1
    end
  end
end

puts nice
