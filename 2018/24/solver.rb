require "advent"
input = Advent.input

# input = <<ENDL.split("\n")
# Immune System:
# 17 units each with 5390 hit points (weak to radiation, bludgeoning) with an attack that does 4507 fire damage at initiative 2
# 989 units each with 1274 hit points (immune to fire; weak to bludgeoning, slashing) with an attack that does 25 slashing damage at initiative 3

# Infection:
# 801 units each with 4706 hit points (weak to radiation) with an attack that does 116 bludgeoning damage at initiative 1
# 4485 units each with 2961 hit points (immune to radiation; weak to fire, cold) with an attack that does 12 slashing damage at initiative 4
# ENDL

class Group < Struct.new(:faction, :id, :units, :health, :damage, :dtype, :initiative, :weakness, :immunity)
  attr_accessor :target
  attr_accessor :enemies

  def power
    units * damage
  end

  def damage_to(enemy)
    damage = power
    damage *= 2 if enemy.weakness.include? dtype
    damage *= 0 if enemy.immunity.include? dtype
    damage
  end

  def priority
    [-power, -initiative]
  end

  def take_damage!(incoming)
    casualties = [incoming / health, units].min
    self.units -= casualties
    casualties
  end

  def attack!
    damage = damage_to(target)
    casualties = target.take_damage!(damage)
    [damage, casualties]
  end
end

immune_system = []
def immune_system.name
  "System"
end
infection = []
def infection.name
  "Infect"
end

def parse(line, faction, i, enemies)
  values = line.match(/(\d+) units each with (\d+) hit points (\(((immune|weak) to ([^;]*))?(; )?((immune|weak) to ([^;]*))?\) )?with an attack that does (\d+) ([^ ]+) damage at initiative (\d+)/).captures
  immunity = ((values[4] == "immune" ? values[5] : values[9]) || "").split(", ")
  weakness = ((values[4] == "weak" ? values[5] : values[9]) || "").split(", ")
  group = Group.new(
    faction,
    i,
    values[0].to_i,
    values[1].to_i,
    values[10].to_i,
    values[11],
    values[12].to_i,
    weakness,
    immunity
  )
  group.enemies = enemies
  group
end

input.shift # label
i = 1
while !input.first.empty?
  immune_system << parse(input.shift, "System", i, infection)
  i += 1
end
input.shift # blank

input.shift # label
i = 1
while !input.empty?
  infection << parse(input.shift, "Infect", i, immune_system)
  i += 1
end

# Calculation

def fight(immune_system, infection, boost: 0)
  immune_system = immune_system.map(&:dup)
  infection = infection.map(&:dup)
  immune_system.each do |group|
    group.damage += boost
    group.enemies = infection
  end
  infection.each do |group|
    group.enemies = immune_system
  end

  round = 0
  while !infection.empty? && !immune_system.empty?
    round += 1
    # Status Update
    # # puts
    # # puts '&' * 40
    # [immune_system, infection].each do |faction|
    #   # puts "#{faction.name}:"
    #   faction.sort_by(&:priority).each do |group|
    #     # puts "Group #{group.id} contains #{group.units} units, #{group.units*group.health}hp (Priority #{group.priority.inspect})"
    #   end
    # end

    # Target Selection
    # puts
    [infection, immune_system].each do |faction|
      targets = []
      faction.sort_by(&:priority).each do |group|
        group.target = nil
        damages = []
        group.enemies.each do |egroup|
          next if targets.include? egroup
          damage = group.damage_to(egroup)
          if damage > 0
            # puts "#{faction.name} group #{group.id} would deal defending group #{egroup.id} #{damage} damage"
            damages << [-damage, -egroup.power, -egroup.initiative, egroup]
          end
        end
        if damages.any?
          targets << damages.sort.first.last
          group.target = damages.sort.first.last
        end
      end
    end

    # Attacking
    # puts
    kills = (infection + immune_system).sort_by(&:initiative).reverse.map do |group|
      next unless group.target
      next if group.units.zero?
      damage, casualties = group.attack!
      # puts "#{group.faction} group #{group.id} (#{group.initiative}) attacks defending group #{group.target.id} for #{damage}, killing #{casualties} units"
      casualties
    end.compact.sum

    break if kills.zero?
    infection.reject! { |group| group.units.zero? }
    immune_system.reject! { |group| group.units.zero? }
  end

  [immune_system, infection]
end

# Part 1

s, i = fight(immune_system, infection)
puts (s + i).sum(&:units)

# Part 2

50.times do |b|
  boost = b + 1
  s, i = fight(immune_system, infection, boost: boost)
  if i.empty?
    puts s.sum(&:units)
    exit
  end
end
