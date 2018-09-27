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
