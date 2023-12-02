require "advent"
input = Advent.input

inxput = <<~IN.split("\n")
  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
IN

# Part 1

limit = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

puts input.filter_map { |line|
  game, reveals = line.split(": ")
  reveals = reveals.split("; ").map { |r| r.split(", ") }
  id = game.scan(/\d+/).first.to_i

  id if reveals.all? { |reveal|
    reveal.all? { |gems|
      n, color = gems.split(" ")
      n.to_i <= limit[color]
    }
  }
}.sum

# Part 2

puts input.map { |line|
  seen = {"red" => 0, "green" => 0, "blue" => 0}
  _, reveals = line.split(": ")
  reveals.split("; ").map { |r| r.split(", ") }.each { |reveal|
    reveal.each { |gems|
      n, color = gems.split(" ")
      seen[color] = [seen[color], n.to_i].max
    }
  }
  seen.values.inject(&:*)
}.sum
