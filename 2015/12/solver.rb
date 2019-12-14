require "advent"
input = Advent.input()

# Part 1
puts input.scan(/-?\d+/).map(&:to_i).inject(&:+)

# Part 2
require "json"
data = JSON.parse(input)

def score(node)
  case node
  when String; 0
  when Numeric; node
  when Array
    node.map { |val| score(val) }.inject(&:+)
  when Hash
    if node.values.any? { |val| val == "red" }
      0
    else
      score(node.values)
    end
  end
end

puts score(data)
