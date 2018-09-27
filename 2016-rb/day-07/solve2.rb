valid = File.readlines('input').select do |line|
  matched = false

  slices = line.chomp.split(/\[|\]/).each_slice(2).to_a
  slices.last << "" # fix parity, for transpose
  supernet, hypernet = slices.transpose.map{|slice| slice.join(' ')}
  (supernet.size - 2).times do |offset|
    aba = supernet[offset, 3]
    next unless aba =~ /([a-z])([a-z])\1/
    a, b = $1, $2
    next if a == b
    bab = "#{b}#{a}#{b}"

    matched = true if hypernet.include?(bab)
  end

  matched
end

puts valid.size
