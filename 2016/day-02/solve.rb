dir_index = {
  'U' => 0,
  'R' => 1,
  'D' => 2,
  'L' => 3
}

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
  [6, 9, 9, 8]
]


num = 5
out = []

File.readlines('input').each do |line|
  line.chomp.split(//).map{|c| dir_index[c]}.each do |step|
    num = moves[num][step]
  end
  out << num
end

puts out.join
