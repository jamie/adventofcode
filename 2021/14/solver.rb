require "advent"
input = Advent.input

inxput = <<~STR.split("\n")
  NNCB

  CH -> B
  HH -> N
  CB -> H
  NH -> C
  HB -> C
  HC -> B
  HN -> C
  NN -> C
  BH -> H
  NC -> B
  NB -> B
  BN -> B
  BB -> N
  BC -> B
  CC -> N
  CN -> C
STR

initial = input[0].split(//)
mapping = input[2..-1].each_with_object({}) do |line, map|
  pair, insertion = line.split(" -> ")
  map[pair.split(//)] = insertion
  map
end

def recurse(left, right, mapping, depth)
  result = {}

  key = [left, right, depth]
  @cache ||= {}
  @cache[key] ||= begin
    insertion = mapping[[left, right]]
    counts = {}
    if depth > 0
      counts[insertion] = 1
      before = recurse(left, insertion, mapping, depth-1)
      after = recurse(insertion, right, mapping, depth-1)
      before.each { |k, v| counts[k] ||= 0; counts[k] += v }
      after.each { |k, v| counts[k] ||= 0; counts[k] += v }
    end
    counts
  end
  @cache[key].each do |k, v|
    result[k] ||= 0
    result[k] += v
  end
  result
end

def count(polymer, mapping, depth)
  elements = {}
  polymer.each do |e|
    elements[e] ||= 0
    elements[e] += 1
  end
  (polymer.size-1).times do |i|
    recurse(polymer[i], polymer[i+1], mapping, depth).each do |k, v|
      elements[k] ||= 0
      elements[k] += v
    end
  end
  elements
end

# Part 1

elements = count(initial, mapping, 10)
puts elements.values.max - elements.values.min

# Part 2

elements = count(initial, mapping, 40)
puts elements.values.max - elements.values.min
