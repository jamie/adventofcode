board = File.readlines('input').map(&:chomp)
$len = board[0].size
$step = 100

def neighbours(board, i, j)
  [ [i+1, j+1],
    [i+1, j  ],
    [i+1, j-1],
    [i  , j+1],
    [i  , j-1],
    [i-1, j+1],
    [i-1, j  ],
    [i-1, j-1],
  ].select do |x, y|
    next unless (0...$len).include? x
    next unless (0...$len).include? y
    board[x][y] == '#'
  end.size
end

$step.times do
  newboard = board.map(&:dup)
  $len.times do |i|
    $len.times do |j|
      if board[i][j] == '#' && (neighbours(board, i, j) < 2 || neighbours(board, i, j) > 3)
        newboard[i][j] = '.'
      elsif board[i][j] == '.' && neighbours(board, i, j) == 3
        newboard[i][j] = '#'
      end
    end
  end
  board = newboard
end

puts board.join.scan(/#/).size
