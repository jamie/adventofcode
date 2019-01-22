require 'advent'
input = Advent.input(2015, 20, :to_i)[0]

# Performance cheating a _lot_ by starting iteration late

# Part 1
house = 780000
goal = input / 10
loop do
  #break if house == 10
  value = 0
  sqrt = Math.sqrt(house)
  (1..sqrt).each do |elf|
    if house % elf == 0
      value += elf
      value += (house/elf) unless elf==sqrt
    end
  end

  #p [house, value]
  if value >= goal
    puts house
    break
  end
  house += 1
end

# Part 2
house = 820000
goal = input / 11
loop do
  #break if house == 10
  value = 0
  sqrt = Math.sqrt(house)
  (1..sqrt).each do |elf|
    if house % elf == 0
      recip = house/elf

      value += elf if recip < 51
      unless elf==sqrt
        value += recip if elf < 51
      end
    end
  end

  #p [house, value]
  if value >= goal
    puts house
    break
  end
  house += 1
end
