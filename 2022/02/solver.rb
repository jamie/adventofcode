require "advent"
input = Advent.input

inpxut = <<~END.split("\n")
  A Y
  B X
  C Z
END

# Part 1

moves = input.map { _1.split(" ") }

results = {
  # WIN
  ["A", "Y"] => 6,
  ["B", "Z"] => 6,
  ["C", "X"] => 6,
  # TIE
  ["A", "X"] => 3,
  ["B", "Y"] => 3,
  ["C", "Z"] => 3,
  # LOSE
  ["A", "Z"] => 0,
  ["B", "X"] => 0,
  ["C", "Y"] => 0
}

points = {
  "X" => 1,
  "Y" => 2,
  "Z" => 3
}
puts(moves.map do |elf_move, you_move|
  points[you_move] + results[[elf_move, you_move]]
end.sum)

# Part 2

move_for = {
  # WIN
  ["A", "Z"] => "Y",
  ["B", "Z"] => "Z",
  ["C", "Z"] => "X",
  # TIE
  ["A", "Y"] => "X",
  ["B", "Y"] => "Y",
  ["C", "Y"] => "Z",
  # LOSE
  ["A", "X"] => "Z",
  ["B", "X"] => "X",
  ["C", "X"] => "Y"
}

puts(moves.map do |elf_move, result|
  you_move = move_for[[elf_move, result]]
  points[you_move] + results[[elf_move, you_move]]
end.sum)
