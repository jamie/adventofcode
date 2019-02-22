require "advent"
input = Advent.input(2016, 19, :to_i)

# Part 1
elves = input.times.to_a

# adjust numbering
elves << elves.size
elves.shift

while elves.size > 1
  shift = elves.size % 2 == 1
  elves = elves.map.with_index(0) { |e, i| e if i % 2 == 0 }.compact
  elves.shift if elves.size > 1 && shift
end

puts elves.first

# Part 2
class Elf
  attr_reader :number, :next

  def initialize(number)
    @number = number
    @next = nil
  end

  def append(elf)
    @next = elf
  end

  def delete_next
    @next = @next.next
  end
end

head = cursor = Elf.new(1)
2.upto(input) do |i|
  cursor.append(Elf.new(i))
  cursor = cursor.next
end
cursor.append(head)

(input / 2).floor.times { cursor = cursor.next }
step = true
while cursor.next != cursor
  cursor.delete_next
  cursor = cursor.next if step
  step = !step
end

puts cursor.number
