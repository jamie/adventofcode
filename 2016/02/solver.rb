require "advent"
input = Advent.input()

dir_index = {
  "U" => 0,
  "R" => 1,
  "D" => 2,
  "L" => 3,
}

# Part 1
moves = [
  [],
  [1, 2, 4, 1],
  [2, 3, 5, 1],
  [3, 3, 6, 2],
  [1, 5, 7, 4],
  [2, 6, 8, 4],
  [3, 6, 9, 5],
  [4, 8, 7, 7],
  [5, 9, 8, 7],
  [6, 9, 9, 8],
]

num = 5
out = []

input.each do |line|
  line.chomp.split(//).map { |c| dir_index[c] }.each do |step|
    num = moves[num][step]
  end
  out << num
end

puts out.join

# Part 2
moves = [
  [],
  [1, 1, 3, 1],

  [2, 3, 6, 2],
  [1, 4, 7, 2],
  [4, 4, 8, 3],

  [5, 6, 5, 5],
  [2, 7, 10, 5],
  [3, 8, 11, 6],
  [4, 9, 12, 7],
  [9, 9, 9, 8],

  [6, 11, 10, 10],
  [7, 12, 13, 10],
  [8, 12, 12, 11],

  [11, 13, 13, 13],
]

num = 5
out = []

input.each do |line|
  line.chomp.split(//).map { |c| dir_index[c] }.each do |step|
    num = moves[num][step]
  end
  out << num
end

puts out.map { |i| i < 10 ? i : (55 + i).chr }.join
