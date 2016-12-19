require 'digest'

input = 'pvhmgsws'
OPEN = /[bcdef]/

queue = [[0, 0, '']]

while !queue.empty?
  x, y, path = queue.shift

  if [x, y] == [3,3]
    puts path
    exit
  end

  hash = Digest::MD5.hexdigest(input+path)
  queue << [x-1, y, path+'U'] if x > 0 && hash[0] =~ OPEN
  queue << [x+1, y, path+'D'] if x < 3 && hash[1] =~ OPEN
  queue << [x, y-1, path+'L'] if y > 0 && hash[2] =~ OPEN
  queue << [x, y+1, path+'R'] if y < 3 && hash[3] =~ OPEN
end
