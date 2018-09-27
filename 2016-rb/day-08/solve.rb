ON = '#' #:on
OFF = '_' #:off

screen = [
  [OFF]*50,
  [OFF]*50,
  [OFF]*50,
  [OFF]*50,
  [OFF]*50,
  [OFF]*50,
]

File.readlines('input').each do |line|
  case line
  when /rect (.*)x(.*)/
    a, b = $1.to_i, $2.to_i
    a.times do |x|
      b.times do |y|
        screen[y][x] = ON
      end
    end
  when /rotate row y=(.*) by (.*)/
    y, b = $1.to_i, $2.to_i
    screen[y] = screen[y].rotate(-b)
  when /rotate column x=(.*) by (.*)/
    x, b = $1.to_i, $2.to_i
    col = screen.map{|row| row[x]}
    colr = col.rotate(-b)
    6.times {|yy| screen[yy][x] = colr[yy]}
  end
end

p screen.flatten.count(ON)
