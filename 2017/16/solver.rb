require "advent"
input = Advent.input
programs = "abcdefghijklmnop"

moves = input.split(",")

cycle_size = 60 # By inspection, sigh.

(1_000_000_000 % cycle_size).times do |ii|
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

  # Part 1
  puts programs if ii.zero?
end
# Part 2
puts programs
