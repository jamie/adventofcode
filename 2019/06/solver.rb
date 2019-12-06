require "advent"
input = Advent.input(2019, 6)

orbits = {}
input.each do |e|
  com, obj = e.split(')')
  orbits[obj] = com
end

count = 0
orbits.keys.each do |obj|
  loop do
    count += 1
    obj = orbits[obj]
    break if obj == 'COM'
  end
end

puts count


you_path = ['YOU']
loop do
  you_path.push(orbits[you_path.last])
  break if you_path.last == 'COM'
end

san_path = ['SAN']
loop do
  san_path.push(orbits[san_path.last])
  break if san_path.last == 'COM'
end

loop do
  break if you_path.last != san_path.last
  you_path.pop
  san_path.pop
end
puts you_path.size + san_path.size - 2
