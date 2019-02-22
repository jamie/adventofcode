require "advent"
input = Advent.input(2017, 15)
a, b = input.map { |line| line.split(/\s/).last.to_i }
# a, b = 65, 8921

a_factor = 16807
b_factor = 48271
modulus = 2147483647

def gen(value, factor, modulus)
  (value * factor) % modulus
end

count = 0
40_000_000.times do |i|
  a = gen(a, a_factor, modulus)
  a_bits = (a & 0xffff)
  b = gen(b, b_factor, modulus)
  b_bits = (b & 0xffff)
  count += 1 if a_bits == b_bits
end
puts count

def genx(value, factor, modulus, multiple = 1)
  loop do
    value = (value * factor) % modulus
    return value if value % multiple == 0
  end
end

count = 0
5_000_000.times do |i|
  a = genx(a, a_factor, modulus, 4)
  a_bits = (a & 0xffff)
  b = genx(b, b_factor, modulus, 8)
  b_bits = (b & 0xffff)
  count += 1 if a_bits == b_bits
end
puts count
