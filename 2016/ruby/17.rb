require "advent"
input = Advent.input(2016, 17)

OPEN = /[bcdef]/

# Part 1
queue = [[0, 0, ""]]

while !queue.empty?
  x, y, path = queue.shift

  if [x, y] == [3, 3]
    puts path
    break
  end

  hash = Digest::MD5.hexdigest(input + path)
  queue << [x - 1, y, path + "U"] if x > 0 && hash[0] =~ OPEN
  queue << [x + 1, y, path + "D"] if x < 3 && hash[1] =~ OPEN
  queue << [x, y - 1, path + "L"] if y > 0 && hash[2] =~ OPEN
  queue << [x, y + 1, path + "R"] if y < 3 && hash[3] =~ OPEN
end

# Part 2
queue = [[0, 0, ""]]
longest = 0

while !queue.empty?
  x, y, path = queue.shift

  if [x, y] == [3, 3]
    longest = path.size
    next
  end

  hash = Digest::MD5.hexdigest(input + path)
  queue << [x - 1, y, path + "U"] if x > 0 && hash[0] =~ OPEN
  queue << [x + 1, y, path + "D"] if x < 3 && hash[1] =~ OPEN
  queue << [x, y - 1, path + "L"] if y > 0 && hash[2] =~ OPEN
  queue << [x, y + 1, path + "R"] if y < 3 && hash[3] =~ OPEN
end

puts longest
