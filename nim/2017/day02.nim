include "../common.nim"

import strutils
import sequtils
import math

const INPUT = readInput(2017, 2)

func checksum(s:string): int =
  var min, max: int
  for line in splitlines(s):
    var values = line.split('\t').map(proc(x: string): int = parseInt($x))
    min = values.foldl(min(a, b))
    max = values.foldl(max(a, b))
    result += (max - min)

proc resultsum(s:string): int =
  for line in splitlines(s):
    let values = line.split('\t').map(proc(x: string): int = parseInt($x))
    for x in values:
      for y in values:
        if x == y:
          break
        elif x.mod(y) == 0:
          result += x.div(y)
        elif y.mod(x) == 0:
          result += y.div(x)

echo checksum(INPUT)
echo resultsum(INPUT)
