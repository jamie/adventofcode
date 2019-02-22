require "advent"
input = Advent.input(2015, 22)
# Manually solved, parts 1 and 2:
# 953: prspmmmmm
puts 953
# 1289: prsprdpdm
puts 1289
exit
# TODO: This looks like it could be legit solved given more effort.

# Part 1
mob = {
  hp: 55,
  atk: 8,
}

player = {
  hp: 50,
  mp: 500,
}

spells = {
  m: { mp: 53, immediate: -> (c, t) { t[:hp] -= 4 } },
  d: { mp: 73, immediate: -> (c, t) { t[:hp] -= 2; c[:hp] += 2 } },
  s: { mp: 113, ongoing: [:shield, 6] },
  p: { mp: 173, ongoing: [:poison, 6] },
  r: { mp: 229, ongoing: [:charge, 5] },
}

def win?(hero, boss, spells, actions)
  hero = hero.dup
  boss = boss.dup
  actions = actions.dup
  effects = []

  while action = actions.shift
    # player turn
    effects.map(&:first).uniq.each do |effect|
      case effect
      when :poison; boss[:hp] -= 3
      when :charge; hero[:mp] += 101
      end
    end
    effects.map! { |effect, duration|
      [effect, duration - 1] if duration > 1
    }.compact!

    hero[:mp] -= spells[action][:mp]
    return false if hero[:mp] < 0
    effect = spells[action]
    effect[:immediate].call(hero, boss) if effect[:immediate]
    effects << effect[:ongoing] if effect[:ongoing]

    # boss turn
    effects.map(&:first).uniq.each do |effect|
      case effect
      when :poison; boss[:hp] -= 3
      when :charge; hero[:mp] += 101
      end
    end
    effects.map! { |effect, duration|
      [effect, duration - 1] if duration > 1
    }.compact!
    return true if boss[:hp] <= 0

    if effects.any? { |effect, duration| effect == :shield }
      hero[:hp] -= boss[:atk] - 7
    else
      hero[:hp] -= boss[:atk]
    end
    return false if hero[:hp] <= 0
  end
  false
end

def cost(spells, actions)
  actions.map { |a| spells[a][:mp] }.inject(&:+)
end

# Manual simulation gave me a win at 1250, server said too high so cap it there.
min = 1250

action_list = spells.keys.map { |e| [e] }
loop do
  actions = action_list.pop
  break if action_list.empty?

  cost = cost(spells, actions)
  next unless cost < min

  if win?(player, mob, spells, actions)
    p [cost, actions]
    min = [min, cost].min
  end

  [actions].product(spells.keys).map(&:flatten).each do |new_actions|
    action_list << new_actions if cost(spells, new_actions) < min
  end
end

puts min

# Part 2
mob = {
  hp: 55,
  atk: 8,
}

player = {
  hp: 50,
  mp: 500,
}

spells = {
  m: { mp: 53, immediate: -> (c, t) { t[:hp] -= 4 } },
  d: { mp: 73, immediate: -> (c, t) { t[:hp] -= 2; c[:hp] += 2 } },
  s: { mp: 113, ongoing: [:shield, 6] },
  r: { mp: 229, ongoing: [:charge, 5] },
  p: { mp: 173, ongoing: [:poison, 6] },
}

def win?(hero, boss, spells, actions)
  hero = hero.dup
  boss = boss.dup
  actions = actions.dup
  effects = []

  while action = actions.shift
    # player turn
    hero[:hp] -= 1
    return false if hero[:hp] <= 0

    effects.map(&:first).uniq.each do |effect|
      case effect
      when :poison; boss[:hp] -= 3
      when :charge; hero[:mp] += 101
      end
    end
    effects.map! { |effect, duration|
      [effect, duration - 1] if duration > 1
    }.compact!

    hero[:mp] -= spells[action][:mp]
    return false if hero[:mp] < 0
    effect = spells[action]
    effect[:immediate].call(hero, boss) if effect[:immediate]
    effects << effect[:ongoing] if effect[:ongoing]

    # boss turn
    effects.map(&:first).uniq.each do |effect|
      case effect
      when :poison; boss[:hp] -= 3
      when :charge; hero[:mp] += 101
      end
    end
    effects.map! { |effect, duration|
      [effect, duration - 1] if duration > 1
    }.compact!
    return true if boss[:hp] <= 0

    if effects.any? { |effect, duration| effect == :shield }
      hero[:hp] -= boss[:atk] - 7
    else
      hero[:hp] -= boss[:atk]
    end
    return false if hero[:hp] <= 0
  end
  false
end

def cost(spells, actions)
  actions.map { |a| spells[a][:mp] }.inject(&:+)
end

# Manual simulation gave me a win at 1382, server said too high so cap it there.
min = 1382

action_list = spells.keys.map { |e| [e] }
loop do
  actions = action_list.pop
  break if action_list.empty?

  cost = cost(spells, actions)
  next unless cost < min

  if win?(player, mob, spells, actions)
    p [cost, actions]
    min = [min, cost].min
  end

  [actions].product(spells.keys).map(&:flatten).each do |new_actions|
    action_list << new_actions if cost(spells, new_actions) < min
  end
end

puts min
