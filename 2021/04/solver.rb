require "advent"
input = Advent.input

xinput = <<~STR.split("\n")
  7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

  22 13 17 11  0
   8  2 23  4 24
  21  9 14 16  7
   6 10  3 18  5
   1 12 20 15 19

  3 15  0  2 22
   9 18 13 17  5
  19  8  7 25 23
  20 11 10 24  4
  14 21 16 12  6

  14 21 17 24  4
  10 16 15  9 19
  18  8 23 26 20
  22 11 13  6  5
   2  0 12  3  7
STR

# Part 1

def winning?(board)
  board.include?([nil, nil, nil, nil, nil]) ||
    board.transpose.include?([nil, nil, nil, nil, nil])
end

def score(board)
  board.flatten.compact.map(&:to_i).sum
end

sequence = input.shift.split(',').map(&:to_i)

boards = input
  .chunk(&:empty?)
  .map(&:last)
  .reject {|group| group.size < 5}
  .map {|board| board.map(&:split).map {|line| line.map(&:to_i)}}

sequence.each do |n|
  boards.each do |board|
    board.each do |row|
      if (i = row.index(n))
        row[i] = nil
      end
    end
    if winning?(board)
      puts score(board) * n.to_i
      break
    end
  end
  break if boards.any? {|board| winning?(board)}
end

# Part 2

boards = input
  .chunk(&:empty?)
  .map(&:last)
  .reject {|group| group.size < 5}
  .map {|board| board.map(&:split).map {|line| line.map(&:to_i)}}

sequence.each do |n|
  boards.each do |board|
    board.each do |row|
      if (i = row.index(n))
        row[i] = nil
      end
    end
  end
  if boards.size == 1 && winning?(boards[0])
    puts score(boards.first) * n
    break
  end
  boards.reject! {|board| winning?(board)}
end
