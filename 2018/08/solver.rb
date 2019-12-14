require "advent"
input = Advent.input.split(" ").map(&:to_i)

def sum_metadata(input)
  sum = 0
  children = input.shift
  metacount = input.shift
  children.times { sum += sum_metadata(input) }
  metacount.times { sum += input.shift }
  sum
end

puts sum_metadata(input.dup)

def value_of(input)
  sum = 0
  children = input.shift
  metacount = input.shift
  child_values = [nil]
  children.times { child_values << value_of(input) }
  if children == 0
    metacount.times { sum += input.shift }
  else
    metacount.times { sum += (child_values[input.shift] || 0) }
  end
  sum
end

puts value_of(input.dup)
