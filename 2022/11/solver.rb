require "advent"
input = Advent.input

inpxut = <<END.split("\n")
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
END

# Part 1

monkeys = input.chunk_while{|before, _| before != ""}.map do |monkey|
  {
    i: monkey[0].scan(/\d+/)[0].to_i,
    items: monkey[1].scan(/\d+/).map(&:to_i),
    op: monkey[2].match(/old (.) (.*)/).captures,
    test_mod: monkey[3].scan(/\d+/)[0].to_i,
    throw_if_true: monkey[4].scan(/\d+/)[0].to_i,
    throw_if_false: monkey[5].scan(/\d+/)[0].to_i,
    inspections: 0,
  }.tap do |monkey|
    monkey[:op] = ["**", 2] if monkey[:op] == ["*", "old"]
    monkey[:op][1] = monkey[:op][1].to_i
  end
end

20.times do
  monkeys.each do |monkey|
    monkey[:inspections] += monkey[:items].size
    while (item = monkey[:items].shift)
      operand = monkey[:op][1] == "old" ? item : monkey[:op][1].to_i
      new_item = (item.send(monkey[:op][0], operand) / 3).floor
      if (new_item % monkey[:test_mod] == 0)
        monkeys[monkey[:throw_if_true]][:items] << new_item
      else
        monkeys[monkey[:throw_if_false]][:items] << new_item
      end
    end
  end
end

pp monkeys.map{_1[:inspections]}.sort.last(2).inject(:*)

# Part 2

monkeys = input.chunk_while{|before, _| before != ""}.map do |monkey|
  {
    i: monkey[0].scan(/\d+/)[0].to_i,
    items: monkey[1].scan(/\d+/).map(&:to_i),
    op: monkey[2].match(/old (.) (.*)/).captures,
    test_mod: monkey[3].scan(/\d+/)[0].to_i,
    throw_if_true: monkey[4].scan(/\d+/)[0].to_i,
    throw_if_false: monkey[5].scan(/\d+/)[0].to_i,
    inspections: 0,
  }.tap do |monkey|
    monkey[:op] = ["**", 2] if monkey[:op] == ["*", "old"]
    monkey[:op][1] = monkey[:op][1].to_i
  end
end

modulus = monkeys.map{_1[:test_mod]}.inject(&:*)

10_000.times do |i|
  monkeys.each do |monkey|
    monkey[:inspections] += monkey[:items].size
    while (item = monkey[:items].shift)
      new_item = item.send(*monkey[:op]) % modulus
      if (new_item % monkey[:test_mod] == 0)
        monkeys[monkey[:throw_if_true]][:items] << new_item
      else
        monkeys[monkey[:throw_if_false]][:items] << new_item
      end
    end
  end
end

pp monkeys.map{_1[:inspections]}.sort.last(2).inject(:*)
