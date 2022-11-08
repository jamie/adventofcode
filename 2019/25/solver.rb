require "advent"
prog = Advent.input

require "intcode"

# Part 1

# TODO: Maybe code automated exploration & looting?
# Manual map: http://bit.ly/350CTL2

# Manually collect safe items, bring to checkpoint
# Unsafe: giant electromagnet, escape pod, photons, molten lava, infinite loop
input = <<~COMMANDS.bytes
  west
  west
  north
  take space heater
  south
  east
  south
  south
  take sand
  north
  east
  take whirled peas
  west
  take festive hat
  north
  east
  south
  take weather machine
  north
  east
  take mug
  east
  south
  east
  south
  take easter egg
  north
  west
  west
  south
  west
  take shell
  south
  inv
COMMANDS
droid = Intcode.new(prog).input!(input)
droid.execute

# Drop all items
all_items = [
  "easter egg", "festive hat", "mug", "sand",
  "shell", "space heater", "weather machine", "whirled peas"
]
input.push(*all_items.map { |item| "drop #{item}\n" }.join.bytes)
droid.execute

input.push(*"south\n".bytes)
droid.execute

0.upto(all_items.size).each do |count|
  commands = []
  all_items.combination(count).each do |items|
    items.each do |item|
      commands << "take #{item}\n"
    end
    commands << "south\n"
    input.push(*commands.join.bytes)
    droid.execute

    log = droid.output.map(&:chr).join
    if !/you are ejected/.match?(log.split("\n")[-22 + count])
      puts log.match(/get in by typing (\d+)/)[1]
      exit
    end

    commands = items.map { |item| "drop #{item}\n" }
    input.push(*commands.join.bytes)
    droid.execute
  end
end
