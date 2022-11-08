require "advent"
input = Advent.input

inpxut = <<~STR.split("\n")
  v...>>.vv>
  .vv>>.vv..
  >>.>v>...v
  >>v>>.>.v.
  v>v.vv.v..
  >.>>..v...
  .vv..>.>v.
  v.v..>>v.v
  ....v..v.>
STR

# Part 1

def step(line, mover)
  empty = "."
  line.map.with_index do |cell, i|
    if cell == mover
      right = line[(i + 1) % line.size]
      right == empty ? right : cell
    elsif cell == empty
      left = line[(i - 1) % line.size]
      left == mover ? left : cell
    else
      cell
    end
  end
end

seabed = input.map { |line| line.split("") }
step = 0
loop do
  step += 1
  changed = false

  seabed = seabed.map do |line|
    line_ = step(line, ">")
    changed = true unless line == line_
    line_
  end
  seabed = seabed.transpose

  seabed = seabed.map do |line|
    line_ = step(line, "v")
    changed = true unless line == line_
    line_
  end
  seabed = seabed.transpose

  break unless changed
end

puts step
