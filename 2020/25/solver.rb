require "advent"
input = Advent.input

cardkey = input[0].to_i
doorkey = input[1].to_i
SUBJECT = 7

MODULUS = 20201227

def find_loop(key)
  loop_size = 0
  value = SUBJECT
  loop do
    break if value == key
    value = (value * SUBJECT) % MODULUS
    loop_size += 1

    break if loop_size > MODULUS
  end
  loop_size
end

card_loop = find_loop(cardkey)
door_loop = find_loop(doorkey)

value = doorkey
card_loop.times do
  value = (value * doorkey) % MODULUS
end
puts value

# Equally valid
# value = cardkey
# door_loop.times do
#   value = (value * cardkey) % MODULUS
# end
# puts value
