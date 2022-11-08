require "advent"
input = Advent.input

# Common

def masks_from(mask)
  ors = ["0"] * 36
  ands = ["1"] * 36
  floats = [nil] * 36
  mask.each_char.with_index do |char, index|
    if char == "1"
      ors[index] = 1
    elsif char == "0"
      ands[index] = 0
    elsif char == "X"
      floats[index] = "X"
    end
  end
  [ors, ands, floats]
end

# Part 1

mem = {}
ors = ands = nil

input.each do |line|
  if line =~ /mask = (.*)/
    ors, ands, _ = masks_from($1)
  else
    line =~ /mem\[(.*)\] = (.*)/
    index = $1.to_i
    value = $2.to_i

    value |= ors.join.to_i(2)
    value &= ands.join.to_i(2)

    mem[index] = value
  end
end
puts mem.values.sum

# Part 2

mem = {}
ors = ands = floats = nil

input.each do |line|
  if line =~ /mask = (.*)/
    ors, ands, floats = masks_from($1)
  else
    line =~ /mem\[(.*)\] = (.*)/
    index = $1.to_i
    value = $2.to_i

    index |= ors.join.to_i(2)
    # index &= ands.join.to_i(2)

    indices = [index]
    floats.each.with_index do |float, i|
      next unless float == "X"

      maska = ["0"] * 36
      maska[i] = "1"

      maskb = ["1"] * 36
      maskb[i] = "0"

      indices = indices.map { |index|
        [index | maska.join.to_i(2), index & maskb.join.to_i(2)]
      }.flatten
    end

    indices.each do |index|
      mem[index] = value
    end
  end
end

puts mem.values.flatten.sum
