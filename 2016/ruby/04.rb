require "advent"
input = Advent.input(2016, 4)

# Part 1
sum = 0

input.each do |line|
  name, sector, checksum = line.scan(/([a-z-]+)-([\d]+)\[([a-z]{5})\]/)[0]
  frequency = name.gsub("-", "").split(//).sort.inject({}) { |h, c| h[c] ||= 0; h[c] += 1; h }
  expected_checksum = frequency.to_a.sort { |x, y|
    if x[1] != y[1]
      y[1] <=> x[1]
    else
      x[0] <=> y[0]
    end
  }.first(5).map(&:first).join

  if expected_checksum == checksum
    sum += sector.to_i
  end
end

puts sum

# Part 2
input.each do |line|
  name_enc, sector, checksum = line.scan(/([a-z-]+)-([\d]+)\[([a-z]{5})\]/)[0]

  rot = sector.to_i % 26
  a = 97

  name = name_enc.tr(("a".."z").to_a.join, (((a + rot).chr.."z").to_a + ("a"..(a + rot - 1).chr).to_a).join)
  puts sector if name == "northpole-object-storage"
end
