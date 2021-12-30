require "advent"
input = Advent.input

# Part 1

easy_count = 0
input.each do |line|
  _patterns, digits = line.split(" | ")
  digits = digits.split(" ")

  easy_count += digits.select {|digit| digit.size == 2 }.count # 1
  easy_count += digits.select {|digit| digit.size == 4 }.count # 4
  easy_count += digits.select {|digit| digit.size == 3 }.count # 7
  easy_count += digits.select {|digit| digit.size == 7 }.count # 8
end

puts easy_count

# Part 2

DIGITS = %w[abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg]

sum = 0
input.each do |line|
  patterns, digits = line.split(" | ")
  patterns = patterns.split(" ").map {|segments| segments.split(//) }
  digits = digits.split(" ").map {|segments| segments.split(//).sort }

  wires = {
    'a' => [],
    'b' => [],
    'c' => [],
    'd' => [],
    'e' => [],
    'f' => [],
    'g' => [],
  }

  # 1
  one = patterns.detect { |digit| digit.size == 2 }
  wires['c'] = one
  wires['f'] = one

  # 7, given 1
  seven = patterns.detect { |digit| digit.size == 3 }
  wires['a'] = seven - one

  # 4, given 1
  four = patterns.detect { |digit| digit.size == 4 }
  wires['b'] = four - one
  wires['d'] = four - one

  # 8, useful later
  eight = patterns.detect { |digit| digit.size == 7 }

  # 3, given 7 and 4
  maybe_three = patterns.select { |digit| digit.size == 5 }
  three = maybe_three.sort_by { |digit| (digit - seven).size }.first
  wires['g'] = three - seven - four

  # 4 and 7 exclude e/g, so given wire g:
  wires['e'] = eight - four - seven - wires['g']

  # wire b is wires in 4 excluding those in 3
  wires['b'] = four - three
  # b's complement is d
  wires['d'] -= wires['b']

  # 2 finally distinguishes c and f
  maybe_two = patterns.select { |digit| digit.size == 5 }
  two = maybe_two.detect { |digit| digit.include?(wires['e'].first) }
  wires['f'] -= two
  wires['c'] -= wires['f']

  mappings = wires.each_with_object({}) do |h, map|
    k, vs = h
    map[vs.first] = k
    map
  end

  sum += digits.map do |digit|
    correct_wires = digit.flat_map { |wire| mappings[wire] }
    DIGITS.index(correct_wires.sort.join)
  end.join.to_i
end

puts sum
