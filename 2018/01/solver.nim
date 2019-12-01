include "advent.nim"

import sequtils
import strutils

const INPUT = readInput(2018, 1).split("\n").
  map(proc (n: string): int = parseInt(n) )

# Part 1
var sum: int = INPUT.foldl( a + b )
echo sum

# Part 2
import sets

const INPUT_LEN = INPUT.len()
var
  freqs = initHashSet[int](65536)
  freq: int = 0
  i: int = 0

while freqs.missingOrExcl(freq):
  freqs.incl(freq)

  freq = freq + INPUT[i]
  i = i + 1
  if i >= INPUT_LEN:
    i = 0

echo freq
