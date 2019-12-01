require "advent"
input = Advent.input(2015, 4)

# Part 1
i = 0
loop do
  i += 1
  if Digest::MD5.hexdigest(input + i.to_s) =~ /^00000/
    puts i
    break
  end
end

# Part 2
i = 0
loop do
  i += 1
  if Digest::MD5.hexdigest(input + i.to_s) =~ /^000000/
    puts i
    break
  end
end
