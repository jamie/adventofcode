require "advent"
input = Advent.input()

# Part 1
sues = input.map do |line|
  # Sue 1: children: 1, cars: 8, vizslas: 7
  name, options = line.split(": ", 2)
  {
    number: name.split(" ").last,
    remembered: eval("{#{options}}"),
  }
end

detected = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1,
}

match = sues.detect do |sue|
  sue[:remembered].all? do |thing, count|
    count == detected[thing]
  end
end

puts match[:number]

# Part 2
sues = input.map do |line|
  # Sue 1: children: 1, cars: 8, vizslas: 7
  name, options = line.split(": ", 2)
  {
    number: name.split(" ").last,
    remembered: eval("{#{options}}"),
  }
end

detected = {
  children: [:==, 3],
  cats: [:>, 7],
  samoyeds: [:==, 2],
  pomeranians: [:<, 3],
  akitas: [:==, 0],
  vizslas: [:==, 0],
  goldfish: [:<, 5],
  trees: [:>, 3],
  cars: [:==, 2],
  perfumes: [:==, 1],
}

match = sues.detect do |sue|
  sue[:remembered].all? do |thing, count|
    count.send(*detected[thing])
  end
end

puts match[:number]
