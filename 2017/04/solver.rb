require "advent"
input = Advent.input

input.select do |line|
  words = line.split(/ +/)
  words.size == words.uniq.size
end.tap { |valid| puts valid.size }

input.select do |line|
  words = line.split(/ +/)
  words.map! { |word| word.split(//).sort.join }
  words.size == words.uniq.size
end.tap { |valid| puts valid.size }
