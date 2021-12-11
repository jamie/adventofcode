require "advent"
input = Advent.input

inxput = <<STR.split("\n")
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
STR

input = input.map{|line| line.split(//).map(&:to_i) }

# Part 1

def flash(input, x, y)
  return if input[x][y] <= 9
  return if input[x][y] > 1000
  $changed = true
  $flashes += 1
  input[x][y] += 1000
  [
    [-1, -1], [0, -1], [1, -1],
    [-1,  0],          [1,  0],
    [-1,  1], [0,  1], [1,  1],
  ].each do |dx, dy|
    i = x + dx
    j = y + dy
    if (0...input.size).cover?(i) && (0...input[i].size).cover?(j)
      input[i][j] += 1
      flash(input, i, j)
    end
  end
end

$flashes = 0

1000.times do |n|
  if n == 100
    # Part 1
    puts $flashes
  end
  if input.flatten.uniq == [0]
    # Part 2
    puts n
    break
  end

  input.size.times do |x|
    input[x].size.times do |y|
      input[x][y] += 1
    end
  end

  loop do
    $changed = false

    input.size.times do |x|
      input[x].size.times do |y|
        flash(input, x, y)
      end
    end

    break unless $changed
  end

  input.size.times do |x|
    input[x].size.times do |y|
      input[x][y] = 0 if input[x][y] > 1000
    end
  end
end
