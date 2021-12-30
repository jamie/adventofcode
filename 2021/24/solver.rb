require "advent"
input = Advent.input

# Translate input by hand to ruby, then hand-optimize
def monad(digits)
  w = x = y = z = 0

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 1
  x += 10
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 2
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 1
  x += 14
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 13
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 1
  x += 14
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 13
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 26
  x += -13
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 9
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 1
  x += 10
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 15
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 26
  x += -13
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 3
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 26
  x += -7
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 6
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 1
  x += 11
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 5
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 1
  x += 10
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 16
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 1
  x += 13
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 1
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 26
  x += -4
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 6
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 26
  x += -9
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 3
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 26
  x += -13
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 7
  y *= x
  z += y

  w = digits.shift
  x *= 0
  x += z
  x %= 26
  z /= 26
  x += -9
  x = x == w ? 1 : 0
  x = x == 0 ? 1 : 0
  y *= 0
  y += 25
  y *= x
  y += 1
  z *= y
  y *= 0
  y += w
  y += 9
  y *= x
  z += y

  z == 0
end

# Part 1

n = 0
min = 10000000000000
max = min + 999999
min.upto(max) do |i|
  digits = i.to_s.split(//).map(&:to_i)
  next if digits.include?(0)
  n = i if monad(digits)
end

puts n
