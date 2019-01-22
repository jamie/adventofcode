data = File.read('input')
ups = data.gsub(/[^(]/, '')
downs = data.gsub(/[^)]/, '')
puts ups.size - downs.size
data = File.read('input')
floor = 0
pos = 0
data.split(//).each do |char|
  pos += 1
  case char
  when '('
    floor += 1
  when ')'
    floor -= 1
  end
  if floor < 0
    puts pos
    exit
  end
end
