require "advent"
prog = Advent.input

require "intcode"

out = []
Intcode.new(prog).output!(out).execute

rows = out.map { |c| c.chr }.join.split("\n")

sum = 0
rows.each_with_index do |row, y|
  next if y == rows.size - 1
  row.split(//).each_with_index do |cell, x|
    next if x == row.size - 1
    if [rows[y - 1][x], rows[y + 1][x], rows[y][x - 1], rows[y][x + 1]].join == "####"
      sum += x * y
    end
  end
end

puts sum

# Part 2
# Subroutine breakdown performed by hand.

prog[0] = "2"

# R 8 R 10 R 10
# R 4 R 8 R 10 R 12
# R 8 R 10 R 10
# R 12 R 4 L 12 L 12
# R 8 R 10 R 10
# R 4 R 8 R 10 R 12
# R 12 R 4 L 12 L 12
# R 8 R 10 R 10
# R 4 R 8 R 10 R 12
# R 12 R 4 L 12 L 12
m = %w(A B A C A B C A B C).join(",")
a = %w(R 8 R 10 R 10).join(",")
b = %w(R 4 R 8 R 10 R 12).join(",")
c = %w(R 12 R 4 L 12 L 12).join(",")

commands = [m, a, b, c, "n", nil].join("\n").each_byte.map { |e| e }
puts Intcode.new(prog).input!(commands).execute
