input = File.read('input').chomp

row = input.split(//)

safe = 0
40.times do
  safe += row.count('.')

  row = row.size.times.map{|i|
    if i == 0
      row[1]
    elsif i == row.size-1
      row[-2]
    elsif (
      (row[i-1] == '^' && row[i+1] == '.') ||
      (row[i-1] == '.' && row[i+1] == '^')
    )
      '^'
    else
      '.'
    end
  }
end

puts safe
