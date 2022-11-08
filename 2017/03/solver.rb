require "advent"
target = Advent.input(:to_i)

x, y = 0, 0
dx, dy = 1, 1

i = 1
n = 1
loop do
  n.times do
    break if i == target
    i += 1
    x += dx
  end
  dx = -dx

  n.times do
    break if i == target
    i += 1
    y += dy
  end
  dy = -dy

  break if i == target
  n += 1
end
puts [x, y].map(&:abs).inject(&:+)

###

values = {}
values[[0, 0]] = 1

x, y = 0, 0
dx, dy = 1, 1

def update(hash, x, y)
  return if hash[[x, y]]
  hash[[x, y]] = [
    hash[[x - 1, y - 1]], hash[[x, y - 1]], hash[[x + 1, y - 1]],
    hash[[x - 1, y]], hash[[x + 1, y]],
    hash[[x - 1, y + 1]], hash[[x, y + 1]], hash[[x + 1, y + 1]]
  ].compact.inject(&:+)
end

n = 1
loop do
  n.times do
    break if values[[x, y]] > target
    x += dx
    update(values, x, y)
  end
  dx = -dx

  n.times do
    break if values[[x, y]] > target
    y += dy
    update(values, x, y)
  end
  dy = -dy

  break if values[[x, y]] > target
  n += 1
end
puts values[[x, y]]
