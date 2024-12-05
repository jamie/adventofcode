require "advent"
input = Advent.input

<<~STR.split("\n")
  47|53
  97|13
  97|61
  97|47
  75|29
  61|13
  75|53
  29|13
  97|29
  53|29
  61|53
  97|53
  61|29
  47|13
  75|47
  97|75
  47|61
  75|61
  47|29
  75|13
  53|13

  75,47,61,53,29
  97,61,53,29,13
  75,29,13
  75,97,47,61,53
  61,13,29
  97,13,75,29,47
STR

# Part 1

rulein, bookin = input.join("\n").split("\n\n")

rules = rulein.split("\n").map { |line| line.split("|") }
books = bookin.split("\n").map { |line| line.split(",") }

correct = books.select do |book|
  0.upto(book.size - 2).all? do |i|
    rules.include?([book[i], book[i + 1]])
  end
end
# Grab middle page, integer division gives us correct index.
# eg. 7 page book with pages 0..6, 7/2 = 3.
puts correct.map { |book| book[book.size / 2].to_i }.sum

# Part 2

incorrect = books - correct

fixed = incorrect.map do |book|
  book.sort do |a, b|
    next 0 if a == b
    rules.include?([a, b]) ? -1 : 1
  end
end

puts fixed.map { |book| book[book.size / 2].to_i }.sum
