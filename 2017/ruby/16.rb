require 'advent'
input = Advent.input(2017, 16)
programs = 'abcdefghijklmnop'

moves = input.split(",")

cycle_size = 60 # By inspection, sigh.

(1_000_000_000 % cycle_size).times do |ii|

  moves.each do |move|
    case move
    when /s(\d+)/
      x = $1.to_i
      programs = programs[-x..-1] + programs[0...-x]
    when /x(\d+)\/(\d+)/
      i, j = $1.to_i, $2.to_i
      programs[i], programs[j] = programs[j], programs[i]
    when /p(.)\/(.)/
      a, b = $1, $2
      i, j = programs.index(a), programs.index(b)
      programs[i], programs[j] = programs[j], programs[i]
    else
      puts "wtf move #{move}"
    end
  end

  # Part 1
  puts programs if ii.zero?
end
# Part 2
puts programs
