sum = 0

File.readlines('input').map do |line|
  name, sector, checksum = line.scan(/([a-z-]+)-([\d]+)\[([a-z]{5})\]/)[0]
  frequency = name.gsub('-','').split(//).sort.inject({}) {|h, c| h[c] ||= 0; h[c] += 1; h}
  expected_checksum = frequency.to_a.sort {|x, y|
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
