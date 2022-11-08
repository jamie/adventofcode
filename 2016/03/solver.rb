require "advent"
input = Advent.input.map { |line| line.split(" ").map(&:to_i) }

# Part 1
triangles = input.each_slice(3).flat_map(&:transpose)

possible = input.select do |triangle|
  triangle.permutation.all? do |a, b, c|
    a + b > c
  end
end
puts possible.size

# Part 2
triangles = input.each_slice(3).flat_map(&:transpose)

possible = triangles.select do |triangle|
  triangle.permutation.all? do |a, b, c|
    a + b > c
  end
end
puts possible.size
