require "advent"
input = Advent.input

# 470 players; last marble is worth 72170 points

PLR = 470
PNT = 72170

# Part 1

players = [0] * PLR
player = 0
board = [0]
current = 0

PNT.times do |i|
  marble = i + 1

  if marble % 23 == 0
    players[player] += marble
    current -= 7
    current %= board.size
    players[player] += board.delete_at(current)
    current %= board.size
  else
    current += 2
    current %= board.size
    board.insert(current, marble)
  end

  player += 1
  player %= players.count
end

puts players.max

# Part 2

# Had to switch Array out for a linked list, mutating the middle of an Array
# is really just too slow at that size.

players = [0] * PLR
player = 0
board = Node.new(0)
current = board

(PNT * 100).times do |i|
  marble = i + 1

  if marble % 23 == 0
    players[player] += marble
    7.times { current = current.left }
    current, deleted_val = current.delete
    players[player] += deleted_val
  else
    current = current.right
    current = current.append(marble)
  end

  player += 1
  player %= players.count
end

puts players.max
