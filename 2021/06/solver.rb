require "advent"
input = Advent.input

inxput = "3,4,3,1,2"

# Part 1

fish = input.split(",").map(&:to_i)

80.times do
  new_fish = []
  fish = fish.map { |f|
    new_fish << 8 if f == 0
    f > 0 ? f - 1 : 6
  }
  fish += new_fish
end

puts fish.size

# Part 2

fish = input.split(",").map(&:to_i)

ttl = [0, 0, 0, 0, 0, 0, 0, 0, 0]
fish.each { |f| ttl[f] += 1 }

256.times do
  birthing = ttl.shift
  ttl[6] += birthing # mothers
  ttl[8] ||= 0
  ttl[8] += birthing # babies
end
puts ttl.sum
