require "advent"
input = Advent.input

# Part 1

start = input[0].to_i

busses = input[1].split(',').reject!{|bus| bus == 'x'}.map(&:to_i)

departure, wait, bus = busses.
  map{|bus|
    t = start.to_f/bus
    f = t-t.to_i
    d = (t-f+1)*bus
    [d, d-start, bus]}.
  sort.
  first

puts wait.to_i*bus

# Part 2 - TODO: Algorithm

schedule = input[1].split(',').map.with_index{|bus,i|
  next if bus=='x'
  [bus.to_i, i]
}.compact

# puts schedule.map{|bus, dx| "(x + #{dx}) modulo #{bus} = 0"}.sort

# (x + 0) modulo 37 = 0
# (x + 27) modulo 41 = 0
# (x + 37) modulo 433 = 0
# (x + 45) modulo 23 = 0
# (x + 54) modulo 17 = 0
# (x + 56) modulo 19 = 0
# (x + 66) modulo 29 = 0
# (x + 68) modulo 593 = 0
# (x + 81) modulo 13 = 0

# Taking the first 5 and plugging into Wolfram Alpha (it won't take more than 7) gives:
# (x + 0) modulo 37 = 0; (x + 27) modulo 41 = 0; (x + 37) modulo 433 = 0; (x + 45) modulo 23 = 0; (x + 54) modulo 17 = 0
# -> 170767802 + 256832651 n1

# the remaining four:
# (x + 56) modulo 19 = 0; (x + 66) modulo 29 = 0; (x + 68) modulo 593 = 0; (x + 81) modulo 13 = 0
# -> 801668 + 4247659 n2

# Those two together make:
# -> x = 170767802 + 256832651 n1; x = 801668 + 4247659 n2
# -> 600691418730595 + 1090937521514009 n
# n=0 is a valid solution for that last equation, so...

puts 600691418730595
