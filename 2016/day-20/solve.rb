input = File.readlines('input')

blocks = input.map do |row|
  row.chomp.split('-').map(&:to_i)
end.sort

allowed = 0

loop do
  min, max = blocks.shift
  if min <= allowed
    allowed = max+1 if max >= allowed
  else
    puts allowed
    exit
  end
end
