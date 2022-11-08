require "advent"
input = Advent.input

# Part 1

POINTS = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137,
  "(" => 1,
  "[" => 2,
  "{" => 3,
  "<" => 4
}
PAIRS = ["()", "[]", "{}", "<>"]
CLOSERS = [")", "]", "}", ">"]

def incorrect_char(line)
  loop do
    last_line = line.dup
    PAIRS.each { |pair| line.gsub!(pair, "") }
    break if line == last_line
  end
  (line.split("") & CLOSERS).first
end

score = input
  .map { |line| incorrect_char(line) }
  .compact
  .map { |char| POINTS[char] }
  .sum
puts score

# Part 2

def incomplete_chars(line)
  loop do
    last_line = line.dup
    PAIRS.each { |pair| line.gsub!(pair, "") }
    break if line == last_line
  end
  line unless (line.split("") & CLOSERS).first
end

def score_incomplete(chars)
  chars.split("").reverse.inject(0) do |score, c|
    score * 5 + POINTS[c]
  end
end

scores = input
  .map { |line| incomplete_chars(line) }
  .compact
  .map { |chars| score_incomplete(chars) }
  .sort
puts scores[scores.size / 2]
