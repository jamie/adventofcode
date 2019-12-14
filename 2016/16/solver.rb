require "advent"
input = Advent.input()

def stretch(input)
  input + "0" + input.reverse.tr("01", "10")
end

SUM = {
  "11" => "1",
  "00" => "1",
  "10" => "0",
  "01" => "0",
}.freeze

def sum(input)
  pairs = input.scan(/[01]{2}/)
  checksum = pairs.map { |i| SUM[i] }.join
  case checksum.size % 2
  when 0; sum(checksum)
  when 1; checksum
  end
end

# Part 1
length = 272

while input.size < length
  input = stretch(input)
end

puts sum(input[0...length])

# Part 2
length = 35651584

while input.size < length
  input = stretch(input)
end

puts sum(input[0...length])
