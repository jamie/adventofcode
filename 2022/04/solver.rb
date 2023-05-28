require "advent"
input = Advent.input

inpxut = <<END.split("\n")
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
END

# Part 1

overlaps = input.select do |line|
  v = line.scan(/\d+/).map(&:to_i)

  r1 = v[0]..v[1]
  r2 = v[2]..v[3]

  r1.cover?(r2) || r2.cover?(r1)
end
puts overlaps.size

# Part 2

overlaps = input.select do |line|
  v = line.scan(/\d+/).map(&:to_i)

  r1 = v[0]..v[1]
  r2 = v[2]..v[3]

  r1.cover?(r2.first) || r2.cover?(r1.first)
end
puts overlaps.size
