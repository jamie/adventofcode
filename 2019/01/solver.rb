require "advent"
input = Advent.input(:to_i)

def fuel(mass, recurse: false)
  return 0 if mass < 7
  f_mass = mass / 3 - 2
  f_mass += fuel(f_mass, recurse: recurse) if recurse
  f_mass
end

puts input.map { |m| fuel(m) }.sum
puts input.map { |m| fuel(m, recurse: true) }.sum
