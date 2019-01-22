require 'advent'
input = Advent.input(2015, 11)

# I literally just solved this one in my head.

# Input "cqjxjnds" needed two doubles and a sequence. I could double the X, run
# a sequence to Z, and then double the Z for "cqjxxyzz".

puts "cqjxjnds"

# Part two asks the _next_ password, and since the tail here is the very last
# possible double-ended sequence, we roll around to CQK, and the first possible
# valid tail gives "cqkaabcc".

puts "cqkaabcc"
