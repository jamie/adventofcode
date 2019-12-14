require "advent"
input = Advent.input()

pos = [0, input[0].index("|")]
dir = :d
message = ""
steps = 0

loop do
  cur = input[pos[0]][pos[1]]
  case cur
  when "+"
    case dir
    when :d, :u
      dir = (input[pos[0]][pos[1] - 1] == "-") ? :l : :r
    when :r, :l
      dir = (input[pos[0] - 1][pos[1]] == "|") ? :u : :d
    end
  when /[A-Z]/
    message << cur
    print cur
  when "|", "-"
    # go straight I guess
  else
    break
  end

  steps += 1
  case dir
  when :d
    pos[0] = pos[0] + 1
  when :u
    pos[0] = pos[0] - 1
  when :r
    pos[1] = pos[1] + 1
  when :l
    pos[1] = pos[1] - 1
  end
end
puts message
puts steps
