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

var
  freqs = initSet[int](256)
  freq: int = 0
  input = INPUT
  value: int

while freqs.missingOrExcl(freq):
  freqs.incl(freq)

  # Performance here is crap, we should really try and just iterate
  if input.len() == 0:
    input = input.concat(INPUT)
  freq = freq + input[0]
  input.delete(0,0)

echo freq
