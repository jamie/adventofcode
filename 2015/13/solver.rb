require "advent"
input = Advent.input

# Part 1
happiness = Hash.new { |h, k| h[k] = {} }

input.each do |line|
  line =~ /(.*) would (.*) (.*) happiness units by sitting next to (.*)\./
  person, feeling, amount, other = Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3).to_i, Regexp.last_match(4)
  amount *= -1 if feeling == "lose"
  happiness[person][other] = amount
end

seatings = happiness.keys.permutation.to_a.map do |order|
  happy = 0
  happy += happiness[order[0]][order[-1]]
  happy += happiness[order[-1]][order[0]]
  (order.size - 1).times do |i|
    happy += happiness[order[i]][order[i + 1]]
    happy += happiness[order[i + 1]][order[i]]
  end
  happy
end

puts seatings.max

# Part 2
happiness = Hash.new { |h, k| h[k] = {} }

input.each do |line|
  line =~ /(.*) would (.*) (.*) happiness units by sitting next to (.*)\./
  person, feeling, amount, other = Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3).to_i, Regexp.last_match(4)
  amount *= -1 if feeling == "lose"
  happiness[person][other] = amount
end

happiness.keys.each do |other|
  happiness["Me!"][other] = 0
  happiness[other]["Me!"] = 0
end

seatings = happiness.keys.permutation.to_a.map do |order|
  happy = 0
  happy += happiness[order[0]][order[-1]]
  happy += happiness[order[-1]][order[0]]
  (order.size - 1).times do |i|
    happy += happiness[order[i]][order[i + 1]]
    happy += happiness[order[i + 1]][order[i]]
  end
  happy
end

puts seatings.max
