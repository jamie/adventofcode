import os
import strformat
import strutils

proc readInput(year:int, day:int): string =
  strip(readFile(fmt"../../input/{year}/{day:02}"))
