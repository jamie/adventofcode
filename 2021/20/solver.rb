require "advent"
input = Advent.input

inxput = <<~STR.split("\n")
  ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

  #..#.
  #....
  ##..#
  ..#..
  ..###
STR

enhancement = input.shift
input.shift # clear blank line
# Build up working array with buffer space for 2 cells of growth

# Part 1

steps = 2
buffer = steps + 1
seafloor = input.map { |line| '.' * buffer + line + '.' * buffer }
buffer.times do
  seafloor.unshift('.' * (input.first.size + 2*buffer))
  seafloor.append('.' * (input.first.size + 2*buffer))
end
seafloor = seafloor.map { |line| line.split(//) }

steps.times do
  high = seafloor.size - 1
  seafloor = seafloor.map.with_index do |row, y|
    row.map.with_index do |cell, x|
      bits = [
        y > 0 && x > 0 && seafloor[y-1][x-1] == '#',
        y > 0 && seafloor[y-1][x] == '#',
        y > 0 && x < high && seafloor[y-1][x+1] == '#',
        x > 0 && seafloor[y][x-1] == '#',
        seafloor[y][x] == '#',
        x < high && seafloor[y][x+1] == '#',
        y < high && x > 0 && seafloor[y+1][x-1] == '#',
        y < high && seafloor[y+1][x] == '#',
        y < high && x < seafloor.size && seafloor[y+1][x+1] == '#',
      ].map { |bit| bit ? '1' : '0' }.join
      index = bits.to_i(2)
      enhancement[index]
    end
  end
end

# Trim corners
seafloor = seafloor[1..-2]
seafloor = seafloor.map { |line| line[1..-2] }

puts seafloor.flatten.count { |cell| cell == '#' }

# Part 2

steps = 50
buffer = steps + 4
seafloor = input.map { |line| '.' * buffer + line + '.' * buffer }
buffer.times do
  seafloor.unshift('.' * (input.first.size + 2*buffer))
  seafloor.append('.' * (input.first.size + 2*buffer))
end
seafloor = seafloor.map { |line| line.split(//) }

steps.times do
  high = seafloor.size - 1
  active_range = 1..(seafloor.size-2)
  seafloor = seafloor.map.with_index do |row, y|
    row.map.with_index do |cell, x|
      bits = [-1, 0, 1].flat_map do |dy|
        [-1, 0, 1].map do |dx|
          if active_range.include?(x+dx) && active_range.include?(y+dy)
            seafloor[y+dy][x+dx] == '#' ? '1' : '0' 
          else
            seafloor[0][0] == '#' ? '1' : '0' 
          end
        end
      end
      index = bits.join.to_i(2)
      enhancement[index]
    end
  end
end

# Trim corners
seafloor = seafloor[1..-2]
seafloor = seafloor.map { |line| line[1..-2] }

puts seafloor.flatten.count { |cell| cell == '#' }
