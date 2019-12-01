require "advent"
input = Advent.input(2018, 15)

class NoTarget < StandardError; end

module ShellText
  def self.style(string, *styles)
    reset = "\e[0m"
    style = {
      default: "\e[39m",
      black: "\e[30m",
      red: "\e[31m",
      green: "\e[32m",
      yellow: "\e[33m",
      blue: "\e[34m",
      magenta: "\e[35m",
      cyan: "\e[36m",
      lgray: "\e[37m",
      dgray: "\e[90m",
      lred: "\e[91m",
      lgreen: "\e[92m",
      lyellow: "\e[93m",
      lblue: "\e[94m",
      lmagenta: "\e[95m",
      lcyan: "\e[96m",
      white: "\e[97m",

      bold: "\e[1m",
    }.slice(*styles).values.join
    "#{style}#{string}#{reset}"
  end
end

class Map
  attr_reader :rounds

  def initialize(input, elf_power: 3)
    @board = input.map.with_index do |line, y|
      line.split(//).map.with_index do |char, x|
        case char
        when "#"
          :wall
        when "."
          EmptyCell.new(x, y)
        when "G"
          Goblin.new(x, y)
        when "E"
          Elf.new(x, y, power: elf_power)
        else
          fail "Unknown input: #{char}"
        end
      end
    end
    @rounds = 0
  end

  def to_s
    @board.map do |line|
      line.map do |cell|
        case cell
        when :wall
          "#"
        when Unit, EmptyCell
          cell.sigil
        end
      end.join + "  " + line.select { |e| e.is_a? Unit }.map(&:to_s).join(", ")
    end.join("\n") + "\n\n"
  end

  def active?
    units(Goblin).any? && units(Elf).any?
  end

  def outcome
    @rounds * units(Unit).sum(&:hp)
  end

  def at(x, y)
    @board[y][x]
  end

  def adjacent_to(x, y, type: nil)
    adjacent = [
      at(x, y - 1),
      at(x - 1, y),
      at(x + 1, y),
      at(x, y + 1),
    ]
    adjacent.select! { |e| e.is_a?(type) } if type
    adjacent
  end

  def distances_from(x, y)
    distances = {}
    distances[[x, y]] = 0
    queue = [[x, y]]

    while queue.any?
      dx, dy = queue.shift
      [[dx, dy - 1], [dx - 1, dy], [dx + 1, dy], [dx, dy + 1]].each do |nx, ny|
        next if distances[[nx, ny]]
        next unless at(nx, ny).empty?
        distances[[nx, ny]] = distances[[dx, dy]] + 1
        queue << [nx, ny]
      end
    end

    distances
  end

  def units(type)
    @board.flatten.select { |e| e.is_a? type }
  end

  def step!
    units(Unit).each do |unit|
      begin
        unit.act!(self)
      rescue NoTarget
        return
      end
    end
    @rounds += 1
  end

  def move!(unit, dest)
    @board[unit.y][unit.x] = EmptyCell.new(unit.x, unit.y)
    @board[dest.y][dest.x] = unit
    unit.x = dest.x
    unit.y = dest.y
  end

  def remove!(unit)
    @board[unit.y][unit.x] = EmptyCell.new(unit.x, unit.y)
  end
end

class Unit
  attr_accessor :x, :y, :hp

  def initialize(x, y, power: 3)
    @x, @y = x, y
    @hp = 200
    @attack_power = power
  end

  def pos
    [x, y]
  end

  def target_sort
    [hp, y, x]
  end

  def adjacent?(other)
    [x - other.x, y - other.y].map(&:abs).sort == [0, 1]
  end

  def to_s
    "#{sigil}(#{hp})"
  end

  def empty?
    false
  end

  def act!(map)
    return if hp <= 0 # premature death check
    raise NoTarget if map.units(enemy_class).empty?
    move(map)
    attack(map)
  end

  def move(map)
    # return if already adjacent to an enemy
    return if map.adjacent_to(x, y, type: enemy_class).any?

    distances = map.distances_from(x, y) # calculate once

    targets = map.units(enemy_class)
    open_squares = targets.
      map { |e| map.adjacent_to(e.x, e.y, type: EmptyCell) }.
      flatten.
      uniq.
      map { |s| [distances[[s.x, s.y]], s.y, s.x, s] }. # sort by distance, reading order
      select { |d, y, x, s| d }. # reject unpathable destinations
      sort.
      map(&:last)
    destination = open_squares.first
    return unless destination

    target_distances = map.distances_from(destination.x, destination.y)
    destination = map.adjacent_to(x, y, type: EmptyCell).
      select { |e| target_distances[[e.x, e.y]] }.
      sort_by { |e| [target_distances[[e.x, e.y]], e.y, e.x] }.
      first

    map.move!(self, destination)
  end

  def attack(map)
    target = map.
      adjacent_to(x, y, type: enemy_class).
      sort_by(&:target_sort).
      first
    if target
      target.hp -= @attack_power
      map.remove!(target) if target.hp <= 0
    end
  end
end

class Elf < Unit
  def sigil
    ShellText.style("E", :green, :bold)
  end

  def enemy_class
    Goblin
  end
end

class Goblin < Unit
  def sigil
    ShellText.style("G", :red, :bold)
  end

  def enemy_class
    Elf
  end
end

class EmptyCell < Struct.new(:x, :y)
  def sigil
    ShellText.style(".", :dgray)
  end

  def target_sort
    [0, y, x]
  end

  def empty?
    true
  end
end

# Sample combat, outcome 27730
# input = [
#   "#######",
#   "#.G...#",
#   "#...EG#",
#   "#.#.#G#",
#   "#..G#E#",
#   "#.....#",
#   "#######",
# ]

# Part 1
combat = Map.new(input)
while combat.active?
  combat.step!
  # puts combat.rounds
  # puts combat
end
puts combat.outcome

# Part 2
(4..1000).each do |elf_power|
  combat = Map.new(input, elf_power: elf_power)
  starting_elves = combat.units(Elf).size

  combat.step! while combat.active?

  break if combat.units(Elf).size == starting_elves
end
puts combat.outcome
