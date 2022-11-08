require "advent"
input = Advent.input

# Part 1
i = 0
loop do
  i += 1
  if /^00000/.match?(Digest::MD5.hexdigest(input + i.to_s))
    puts i
    break
  end
end

# Part 2
i = 0
loop do
  i += 1
  if /^000000/.match?(Digest::MD5.hexdigest(input + i.to_s))
    puts i
    break
  end
end
