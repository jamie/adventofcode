require "advent"
input = Advent.input

# Part 1

dx = input[0].size
dy = input.size
counts = 0

(0...dy).each do |y|
  (0...dx).each do |x|
    # Horizontal
    counts += 1 if input[y][x...x + 4] == "XMAS" || input[y][x...x + 4] == "SAMX"

    # Vertical
    word = [input[y][x], input[y + 1][x], input[y + 2][x], input[y + 3][x]].join
    counts += 1 if word == "XMAS" || word == "SAMX"

    # Diagonal
    word = [input[y][x], input[y + 1][x + 1], input[y + 2][x + 2], input[y + 3][x + 3]].join
    counts += 1 if word == "XMAS" || word == "SAMX"
    word = [input[y][x + 3], input[y + 1][x + 2], input[y + 2][x + 1], input[y + 3][x]].join
    counts += 1 if word == "XMAS" || word == "SAMX"
  rescue
    next
    # Skip indexing errors
  end
end
puts counts

# Part 2

counts = 0

(1..dy - 2).each do |y|
  (1..dx - 2).each do |x|
    next unless input[y][x] == "A"
    adj = [
      input[y - 1][x - 1],
      input[y - 1][x + 1],
      input[y + 1][x - 1],
      input[y + 1][x + 1]
    ].compact
    counts += 1 if [%w[M S M S], %w[M M S S], %w[S M S M], %w[S S M M]].include?(adj)
  end
end
puts counts
