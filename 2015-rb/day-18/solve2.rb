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
    next if x < 0 or x >= $len
    next if y < 0 or y >= $len
    board[x][y] == '#'
  end.size
end

$step.times do
  newboard = board.map(&:dup)
  $len.times do |i|
    $len.times do |j|
      next if [[0,0],[0,99],[99,0],[99,99]].include? [i,j]
      n = neighbours(board, i, j)
      if board[i][j] == '#' && (n < 2 || n > 3)
        newboard[i][j] = '.'
      elsif board[i][j] == '.' && n == 3
        newboard[i][j] = '#'
      end
    end
  end
  board = newboard
end

puts board.join.scan(/#/).size
