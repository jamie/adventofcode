require 'advent'
input = Advent.input(2017, 17, :to_i)[0]

buffer = [0]
index = 0
2017.times do |i|
  new_val = i+1
  index = (index + input) % buffer.size
  buffer.insert(index + 1, new_val)
  index += 1
end

puts buffer[index+1]


#buffer = [0]
index = 0
size = 1
buffer_at_1 = nil
50_000_000.times do |i|
  new_val = i+1
  index = (index + input) % size
  buffer_at_1 = new_val if index == 0
  #buffer.insert(index + 1, new_val)
  size = size + 1
  index += 1
end

puts buffer_at_1
