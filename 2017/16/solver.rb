require "advent"
input = Advent.input
programs = "abcdefghijklmnop"

moves = input.split(",")

def dance(programs, moves)
  programs = programs.dup
  moves.each do |move|
    case move
    when /s(\d+)/
      x = Regexp.last_match(1).to_i
      programs = programs[-x..-1] + programs[0...-x]
    when /x(\d+)\/(\d+)/
      i, j = Regexp.last_match(1).to_i, Regexp.last_match(2).to_i
      programs[i], programs[j] = programs[j], programs[i]
    when /p(.)\/(.)/
      a, b = Regexp.last_match(1), Regexp.last_match(2)
      i, j = programs.index(a), programs.index(b)
      programs[i], programs[j] = programs[j], programs[i]
    else
      puts "wtf move #{move}"
    end
  end
  programs
end

# Part 1
puts dance(programs, moves)

# Part 2

seen = [programs]

loop do
  programs = dance(programs, moves)
  break if seen.include?(programs)
  seen << programs
end

cycle_size = seen.size - seen.index(programs)
puts seen[1000000000 % cycle_size]

