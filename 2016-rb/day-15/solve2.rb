discs = []
File.readlines('input').each do |line|
  fail unless line =~ /Disc #(.*) has (.*) positions; at time=0, it is at position (.*)./
  discs << [$1, $2, $3].map(&:to_i)
  discs[-1][2] += discs.size
end
discs << [7, 11, discs.size+1]

time = 0
loop do
  break if discs.map(&:last).all? { |pos| pos.zero? }
  discs.map! do |id, size, pos|
    [id, size, (pos+1)%size]
  end
  time += 1
end

puts time