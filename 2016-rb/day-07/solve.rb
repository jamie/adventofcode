valid = File.readlines('input').select do |line|
  line =~ /(.)(.)\2\1/ && line !~ /\[[^\]]*(.)(.)\2\1[^\]]*\]/ && line !~ /(.)\1\1\1/
end

puts valid.size
