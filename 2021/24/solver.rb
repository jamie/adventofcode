require "advent"
input = Advent.input

# Translate input by hand to ruby, then hand-optimize
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
    (z / q)
  else
    (z / q) * 26 + w + n2
  end
end

# Part 1

n = 0
n_ = 0
sum = 0
min = 11111111111111
max = 99_999_999_999_999
max.downto(min) do |i|
  digits = i.to_s.split(//).map(&:to_i)
  n_ += 1
  next if digits.include?(0)
  n += 1

  m = monad(digits)
  if m == 0
    puts digits.join
    break
  end

  sum += m
  break if n >= 50_000
end

p [n, n_, sum]
