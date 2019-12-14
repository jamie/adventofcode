require "advent"
input = Advent.input.map { |line| line.split("\t").map(&:to_i) }

puts input.map { |values| values.max - values.min }.inject(&:+)

puts input.map { |values|
  values.product(values).
    map { |a, b| a.to_f / b }.
    detect { |x| x > 1 && x == x.to_i }
}.inject(&:+).to_i
