require 'advent'
input = Advent.input(2015, 20)

# Part 1
goal = 3_400_000_0

ary = []
house = 400000
loop do
  #break if house == 10
  ary[house] = 0
  sqrt = Math.sqrt(house)
  (1..sqrt).each do |elf|
    if house % elf == 0
      ary[house] += elf*10
      ary[house] += (house/elf)*10 unless elf==sqrt
    end
  end

  #p [house, ary[house]]
  if ary[house] >= goal
    puts house
    break
  end
  house += 1
end

# Part 2
goal = 3_400_000_0

ary = []
house = 800000
loop do
  #break if house == 10
  ary[house] = 0
  sqrt = Math.sqrt(house)
  (1..sqrt).each do |elf|
    if house % elf == 0
      recip = house/elf

      ary[house] += elf*11 if recip < 51
      unless elf==sqrt
        ary[house] += recip*11 if elf < 51
      end
    end
  end

  #p [house, ary[house]]
  if ary[house] >= goal
    puts house
    break
  end
  house += 1
end