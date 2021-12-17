require "advent"
input = Advent.input

inxput = <<~STR.split("\n")
  1163751742
  1381373672
  2136511328
  3694931569
  7463417111
  1319128137
  1359912421
  3125421639
  1293138521
  2311944581
STR
input = input.map { |line| line.split(//).map(&:to_i) }

# Part 1

def lowest_risk(input)
  pos = [0, 0]
  goal = [input.last.size-1, input.size-1]
  raise "Non-square grid" if goal.uniq.size > 1
  bounds = (pos.first)..(goal.first)

  queue = PriorityDeque.new(:min)
  queue.add(0, [pos, 0])

  seen = {[0, 0] => 0}

  loop do
    break if queue.empty?
    pos, cost = queue.shift
    break if seen[goal]

    [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dx, dy|
      x, y = pos
      dpos = [x+dx, y+dy]
      next if seen[dpos]

      if bounds.cover?(x+dx) && bounds.cover?(y+dy)
        dcost = cost + input[y+dy][x+dx]
        seen[dpos] = dcost
        distance = (goal[0] - dpos[0]) + (goal[1] - dpos[1])
        priority = dcost # TODO: Incorporate distance as a speed optimization?
        queue.add(priority, [dpos, dcost])
      end
    end
  end

  # p [seen.size]
  seen[goal]
end

puts lowest_risk(input)

# Part 2

def succ(n)
  n == 9 ? 1 : n+1
end

n = input.last.size
4.times do
  # Expand rows
  n.times do |x|
    input.each { |row| row << succ(row[row.size-n]) }
  end
end
4.times do
  # Expand columns
  n.times do |y|
    input << input[input.size-n].map { |risk| succ(risk) }
  end
end

puts lowest_risk(input)
