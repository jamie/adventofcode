require "advent"
input = Advent.input

inxput = <<IN.split("\n")
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
IN

# Part 1

puts input.map { |line|
  first = line.scan(/\d/).first
  last = line.scan(/\d/).last
  (first+last).to_i
}.compact.sum

# Part 2

inxput = <<IN.split("\n")
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
IN

NUMBERS = {
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9",
  "zero" => "0",
  "1" => "1",
  "2" => "2",
  "3" => "3",
  "4" => "4",
  "5" => "5",
  "6" => "6",
  "7" => "7",
  "8" => "8",
  "9" => "9",
  "0" => "0"
}
puts input.map { |line|
  # (?=...) is a lookahead assertion, so we can scan for overlapping matches
  numbers = line.scan(/(?=(#{NUMBERS.keys.join("|")}))/).flatten
  first, last = NUMBERS[numbers.first], NUMBERS[numbers.last]
  (first+last).to_i
}.compact.sum

# puts input.map(&:sum).sort[-3..-1].sum
