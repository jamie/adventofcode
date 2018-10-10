include "../common.nim"

import sequtils
import strutils

const INPUT = readInput(2017, 1)

func getDigits(): seq[int] =
  for i in 0..(len(INPUT)-1):
    result.add(parseInt($INPUT[i]))

const
  digits = getDigits()
  size = len(digits)

var
  sum: int = 0
  sum2: int = 0

# Part 1
for i in 0..size-1:
  if digits[i] == digits[(i+1) %% size]:
    sum += digits[i]
echo sum

# Part 2
for i in 0..size-1:
  if digits[i] == digits[(i + size/%2) %% size]:
    sum2 += digits[i]
echo sum2
