input = 3014387

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

(input/2).floor.times { cursor = cursor.next }
step = true
while cursor.next != cursor
  cursor.delete_next
  cursor = cursor.next if step
  step = !step
end

puts cursor.number
