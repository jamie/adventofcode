require 'advent'
input = Advent.input(2015, 1)[0]

# Part 1
ups = input.gsub(/[^(]/, '')
downs = input.gsub(/[^)]/, '')
puts ups.size - downs.size

# Part 2
floor = 0
pos = 0
input.split(//).each do |char|
  pos += 1
  case char
  when '('
    floor += 1
  when ')'
    floor -= 1
  end
  if floor < 0
    puts pos
    exit
  end
end
