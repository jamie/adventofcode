input = "197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63"

require './knothash'

lengths = input.split(',').map(&:to_i)
knot = KnotHash.new(lengths, [])
knot.run_round
puts knot.product

lengths = input.bytes
knot = KnotHash.new(lengths)
puts knot.hexdigest
