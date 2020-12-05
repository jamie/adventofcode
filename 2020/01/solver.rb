require "advent"
input = Advent.input

xinput = <<STR.split("\n")
1721
979
366
299
675
1456
STR

numbers = input.map(&:to_i)

# Part 1
numbers.each_with_index do |x, i|
  numbers[i+1..-1].each do |y|
    if x+y == 2020
      puts x*y
    end
  end
end

# Part 2
numbers.each_with_index do |x, i|
  numbers[i+1..-1].each_with_index do |y, j|
    numbers[i+j+1..-1].each do |z|
      if x+y+z == 2020
        puts x*y*z
      end
    end
  end
end
