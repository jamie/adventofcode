import os
import strformat
import strutils

proc readInput(year:int, day:int): string =
  strip(readFile(fmt"{year}/input/{day:02}"))
