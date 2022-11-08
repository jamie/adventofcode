require "advent"
input = Advent.input

def points(line)
  x = y = t = 0
  wire = []
  times = {}
  line.split(",").each do |dir|
    dist = dir[1..-1].to_i
    case dir[0]
    when "R"
      dist.times {
        x += 1
        t += 1
        wire << [x, y]
        times[[x, y]] ||= t
      }
    when "L"
      dist.times {
        x -= 1
        t += 1
        wire << [x, y]
        times[[x, y]] ||= t
      }
    when "U"
      dist.times {
        y -= 1
        t += 1
        wire << [x, y]
        times[[x, y]] ||= t
      }
    when "D"
      dist.times {
        y += 1
        t += 1
        wire << [x, y]
        times[[x, y]] ||= t
      }
    end
  end
  [wire, times]
end

wire1, times1 = points(input[0])
wire2, times2 = points(input[1])

crossings = wire1 & wire2

puts crossings.map { |x, y| x.abs + y.abs }.min

puts crossings.map { |x, y| times1[[x, y]] + times2[[x, y]] }.min
