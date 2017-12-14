input = File.read('input/11')

steps = input.split(",")

def magnatude(x, y, z)
  [x, y, z].map(&:abs).max
end

# Cube coords, thanks redblobgames
x = y = z = 0
distances = []
steps.each do |step|
  case step
  when 'n' ; y += 1; z -= 1
  when 's' ; y -= 1; z += 1
  when 'nw'; y += 1; x -= 1
  when 'se'; y -= 1; x += 1
  when 'ne'; x += 1; z -= 1
  when 'sw'; x -= 1; z += 1
  end
  distances << magnatude(x, y, z)
end
puts distances.last
puts distances.max
