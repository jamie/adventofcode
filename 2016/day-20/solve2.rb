input = File.readlines('input')

MAX = 4294967296

blocks = input.map do |row|
  row.chomp.split('-').map(&:to_i)
end.sort + [[MAX, MAX]]

allowed = 0

permit_count = 0

loop do
  min, max = blocks.shift
  if min > allowed
    permit_count += (min - allowed)
  end
  break if max == MAX
  allowed = max+1 if max >= allowed
end

puts permit_count
