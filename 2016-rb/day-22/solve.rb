input = File.readlines('input')[2..-1]

# Node, Size, Used, Avail, Use%
dfh = input.map{|line| line.chomp.split(/T? +/)}

viable = []

dfh.each do |node_a, size_a, used_a, avail_a, _|
  dfh.each do |node_b, size_b, used_b, avail_b, _|
    next if used_a == '0'
    next if node_a == node_b
    next if used_a.to_i > avail_b.to_i
    viable << [node_a, node_b].sort
  end
end

puts viable.uniq.size
