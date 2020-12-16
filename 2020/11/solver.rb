require "advent"
input = Advent.input

OCCUPIED = '#'
EMPTY = 'L'
FLOOR = '.'

# Part 1

seats = input
last = seats.join
n = 0
loop do
  seatsp = seats.map(&:dup)
  seats.size.times do |i|
    seats[0].size.times do |j|
      next if seats[i][j] == FLOOR
      
      neighbours = DIRS.count do |di,dj|
        next false if i + di < 0
        next false if i + di >= seats.size
        next false if j + dj < 0
        next false if j + dj >= seats[0].size
        seats[i+di][j+dj] == OCCUPIED
      end

      if neighbours == 0
        seatsp[i][j] = OCCUPIED
      elsif neighbours >= 4
        seatsp[i][j] = EMPTY
      end
    end
  end

  last = seats.join
  seats = seatsp
  n += 1
  break if last == seats.join
end
puts seats.join.count(OCCUPIED)

## Part 2

seats = input
last = seats.join
n = 0
loop do
  seatsp = seats.map(&:dup)
  seats.size.times do |i|
    seats[0].size.times do |j|
      next if seats[i][j] == FLOOR
      
      neighbours = DIRS.count do |di,dj|
        s = 1
        loop do
          ip, jp = i + di*s, j + dj*s
        
          break false if ip < 0 || ip >= seats.size
          break false if jp < 0 || jp >= seats[0].size
          if seats[ip][jp] == FLOOR
            s += 1
          else
            break seats[ip][jp] == OCCUPIED
          end
        end
      end

      if neighbours == 0
        seatsp[i][j] = OCCUPIED
      elsif neighbours >= 5
        seatsp[i][j] = EMPTY
      end
    end
  end

  last = seats.join
  seats = seatsp
  n += 1
  break if last == seats.join
end
puts seats.join.count(OCCUPIED)
