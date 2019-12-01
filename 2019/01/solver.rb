require "advent"
input = Advent.input(2019, 1, :to_i)

# Part 1
def fuel(mass)
  mass / 3 - 2
end

puts input.map { |m| fuel(m) }.inject(&:+)

# Part 2
def fuel2(mass)
  t_mass = f_mass = mass / 3 - 2
  loop do
    f_mass = f_mass / 3 - 2
    break if f_mass < 0
    t_mass += f_mass
  end
  t_mass
end

puts input.map { |m| fuel2(m) }.inject(&:+)
