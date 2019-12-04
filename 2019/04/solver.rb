require "advent"
input = Advent.input(2019, 4)

min, max = input.split("-").map(&:to_i)

count = count2 = 0
min.upto(max).each do |password|
  password = password.to_s

  next unless password =~ /(\d)\1/
  #                       v # lookahead regex to match overlaps
  next if password.scan(/(?=(..))/).any? { |x| x[0][0] > x[0][1] }
  count += 1
  count2 += 1 if password.scan(/((\d)\2+)/).any? { |group| group[0].size == 2 }
end

puts count
puts count2
