world = []
x = 0
y = 0

def gift!(world, x, y)
  world[x+1000] ||= []
  world[x+1000][y+1000] ||= 0
  world[x+1000][y+1000] += 1
end

gift!(world, x, y)

File.read('input').split(//).each do |cmd|
  case cmd
  when '>'
    x += 1
  when '<'
    x -= 1
  when 'v'
    y -= 1
  when '^'
    y += 1
  end
  gift!(world, x, y)
end

puts world.flatten.compact.size
