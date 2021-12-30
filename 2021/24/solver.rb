require "advent"
input = Advent.input

# This started with some manual analysis, a bunch of head-scratching,
# and then 2 minutes of pencil work. In short, we can translate to ruby,
# extract the duplication to a method, and then hand optimize.

def monad(digits)
  z = 0
  z = monad_digit(z, digits.shift, 1, 10, 2)
  z = monad_digit(z, digits.shift, 1, 14, 13)
  z = monad_digit(z, digits.shift, 1, 14, 13)
  z = monad_digit(z, digits.shift, 26, -13, 9)
  z = monad_digit(z, digits.shift, 1, 10, 15)
  z = monad_digit(z, digits.shift, 26, -13, 3)
  z = monad_digit(z, digits.shift, 26, -7, 6)
  z = monad_digit(z, digits.shift, 1, 11, 5)
  z = monad_digit(z, digits.shift, 1, 10, 16)
  z = monad_digit(z, digits.shift, 1, 13, 1)
  z = monad_digit(z, digits.shift, 26, -4, 6)
  z = monad_digit(z, digits.shift, 26, -9, 3)
  z = monad_digit(z, digits.shift, 26, -13, 7)
  z = monad_digit(z, digits.shift, 26, -9, 9)
  z
end

def monad_digit(z, w, q, n1, n2)
  if w == z % 26 + n1
    z / q
  else
    (z / q) * 26 + w + n2
  end
end

# Then analysis leads to noticing that when q is 1 we prefer the second
# path, which:
# - shifts current z state up (* 26)
# - store w + n2
# On a 26 however, we note n1 is negative and so the if could be rewritten
# as `w - n1 == z % 26`. With the insight that we can treat a 1/26 as a pair,
# then `z % 26` was the `w + n2` from prior iteration.
# If we can constrain the two relevant input digits to balance some equations,
# - [1] w + n2
# - [26] w - n1 (note n1 is negative)
# then we can simply manually assemble the relevant digit pairings. For my
# input, these look like:
#   / - - - - - -7- - - - - - \
#   | / - -6- - \ / - -8- - \ |
#   | | /0\ /2\ | | / -7- \ | |
#   | | | | | | | | | /3\ | | |
#   9 3 9 9 7 9 9 9 2 9 6 9 1 2
# giving the highest value (Part 1).
# Scaling each pair down to include a 1 (ie, making the outer pair 8...1)
# gives the lowest matching value (Part 2).

puts 93997999296912
puts 81111379141811

# TBD sometime maybe, we can parse out the relevant constants from the input,
# and then set up constraints programmatically to enumerate all valid serial
# numbers.
