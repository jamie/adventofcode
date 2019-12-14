require "advent"
input = Advent.input(:to_i)

def run(jumps, lo, hi)
  i = 0
  n = 0
  while (0...jumps.size).include? i
    j = i
    i += jumps[j]
    if jumps[j] >= 3
      jumps[j] += hi
    else
      jumps[j] += lo
    end
    n += 1
  end
  puts n
end

run(input.dup, 1, 1)
run(input.dup, 1, -1)
