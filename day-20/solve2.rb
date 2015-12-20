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

  p [house, ary[house]]
  if ary[house] >= goal
    puts house
    break
  end
  house += 1
end
