include "advent.nim"

import sequtils
import strutils

const INPUT = readInput(2017, 1)

func getDigits(): seq[int] =
  for i in 0..(len(INPUT)-1):
    result.add(parseInt($INPUT[i]))

const
  digits = getDigits()
  size = len(digits)

# Functional
proc count(digits:seq[int], shifted_digits:seq[int]): int =
  digits.zip(shifted_digits).
    filter(proc (t:tuple[a:int, b:int]): bool = t.a == t.b ).
    map(proc (t:tuple[a:int, b:int]): int = t.a ).
    foldl( a + b )

var digits_shift_1 =
  digits[1..(len(digits)-1)].concat(@[digits[0]])
var digits_shift_half =
  digits[(size/%2)..(len(digits)-1)].concat(digits[0..(size/%2-1)])

echo count(digits, digits_shift_1)
echo count(digits, digits_shift_half)

# Imperative
var
  sum: int = 0
  sum2: int = 0

# Part 1
for i in 0..size-1:
  if digits[i] == digits[(i+1) %% size]:
    sum += digits[i]
# echo sum

# Part 2
for i in 0..size-1:
  if digits[i] == digits[(i + size/%2) %% size]:
    sum2 += digits[i]
# echo sum2
