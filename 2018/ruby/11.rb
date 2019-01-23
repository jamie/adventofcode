require 'advent'
input = Advent.input(2018, 11, :to_i)

grid = 300.times.map {|row|
  300.times.map {|col|
    x = row + 1
    y = col + 1
    rack = x + 10

    power = rack * y
    power += input
    power *= rack
    power = power.to_s[-3].to_i
    power - 5
  }
}

def solve(grid, size)
  max = 0
  max_pos = []
  
  (301-size).times {|row|
    (301-size).times {|col|
      x = row
      y = col
  
      value = grid[x...(x+size)].map{|row| row[y...(y+size)]}.flatten.sum
      if value > max
        max = value
        max_pos = [x+1, y+1]
      end
    }
  }
  [max, max_pos, size]
end

# Part 1

puts solve(grid, 3)[1].join(',')

# Part 2

# 20 is a heuristic, overall value grows to a local max, then starts dropping off
best = 20.times.map {|i| solve(grid, i+1) }.sort.last
puts (best[1] + [best[2]]).join(',')
