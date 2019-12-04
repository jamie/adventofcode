require "advent"
input = Advent.input(2019, 4)

min, max = input.split("-").map(&:to_i)

count = 0
min.upto(max).each do |password|
  next unless password.to_s =~ /(\d)\1/
  digits = password.to_s.split(//).map(&:to_i)
  next unless digits == digits.sort
  count += 1
end

puts count

count = 0
min.upto(max).each do |password|
  password = password.to_s

  next unless password =~ /(\d)\1/
  digits = password.split(//).map(&:to_i)
  next unless digits == digits.sort

  short = false
  password.scan(/(\d)\1/).each do |group|
    digit = group[0]
    short = true if (password =~ /#{digit}{3}/).nil?
  end

  count += 1 if short
end

puts count
