require "advent"
input = Advent.input(2017, 10)

require "knothash"

lengths = input.split(",").map(&:to_i)
knot = KnotHash.new(lengths, [])
knot.run_round
puts knot.product

lengths = input.bytes
knot = KnotHash.new(lengths)
puts knot.hexdigest
