require "advent"
input = Advent.input

# Part 1

def step(bugs)
  newbugs = []
  5.times.map do |x|
    5.times.map do |y|
      adjacents = [
        [x - 1, y],
        [x + 1, y],
        [x, y + 1],
        [x, y - 1],
      ]
      adjacent = (bugs & adjacents).count

      if bugs.include? [x, y]
        dead = adjacent != 1
        newbugs << [x, y] if !dead
      else
        infest = adjacent == 1 || adjacent == 2
        newbugs << [x, y] if infest
      end
    end
  end
  newbugs.sort
end

def biodiversity(bugs)
  total = 0
  points = 1
  5.times.map do |y|
    5.times.map do |x|
      total += points if bugs.include?([x, y])
      points *= 2
    end
  end
  total
end

bugs = []
5.times.map do |x|
  5.times.map do |y|
    bugs << [x, y] if input[y][x] == "#"
  end
end
bugs.sort!

history = []
loop do
  if history.include? bugs
    puts biodiversity(bugs)
    break
  end
  history << bugs
  bugs = step(bugs)
end

# Part 2

def step2(bugs)
  newbugs = []
  zs = bugs.map{ |z| z / 100 }
  5.times.map do |x|
    5.times.map do |y|
      next if [x, y] == [2, 2]
      (zs.min - 1).upto(zs.max + 1) do |z|
        bug = (x + y * 10 + z * 100)
        adjacents = [bug - 1, bug + 1, bug - 10, bug + 10]
        adjacents << (z - 1) * 100 + 21 if x == 0
        adjacents << (z - 1) * 100 + 23 if x == 4
        adjacents << (z - 1) * 100 + 12 if y == 0
        adjacents << (z - 1) * 100 + 32 if y == 4
        adjacents += 5.times.map { |i| (z + 1) * 100 + i * 10 } if [x, y] == [1, 2]
        adjacents += 5.times.map { |i| (z + 1) * 100 + i * 10 + 4 } if [x, y] == [3, 2]
        adjacents += 5.times.map { |i| (z + 1) * 100 + i } if [x, y] == [2, 1]
        adjacents += 5.times.map { |i| (z + 1) * 100 + 40 + i } if [x, y] == [2, 3]

        adjacent = (bugs & adjacents).count

        if bugs.include? bug
          dead = adjacent != 1
          newbugs << bug if !dead
        else
          infest = adjacent == 1 || adjacent == 2
          newbugs << bug if infest
        end
      end
    end
  end
  newbugs.sort
end

bugs = []
5.times.map do |x|
  5.times.map do |y|
    bugs << (x + y * 10) if input[y][x] == "#"
  end
end
bugs.sort!

200.times { |i| p [i, bugs.size]; bugs = step2(bugs) }
puts bugs.count
