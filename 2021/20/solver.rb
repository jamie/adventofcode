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

def solve(input, enhancement, steps)
  buffer = steps + 1
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

  seafloor.flatten.count { |cell| cell == '#' }
end

# Part 1
puts solve(input, enhancement, 2)

# Part 2
puts solve(input, enhancement, 50)
