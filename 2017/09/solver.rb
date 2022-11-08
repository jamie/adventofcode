require "advent"
input = Advent.input
stream = input.chomp.split("")

$garbage = []

def parse_group(depth, stream)
  score = depth

  loop do
    case stream.shift
    when "{" then score += parse_group(depth + 1, stream)
    when "}" then break
    when "<" then parse_garbage(stream)
    when "," # nop
    else
      exit "Unhandled char"
    end
  end
  score
end

def parse_garbage(stream)
  while stream[0] != ">"
    if stream[0] == "!"
      stream.shift
      stream.shift
    else
      $garbage << stream.shift
    end
  end
  stream.shift
end

stream.shift
puts parse_group(1, stream)
puts $garbage.size
