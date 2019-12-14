require "advent"
input = Advent.input()

# Part 1
mob = {
  hp: 104,
  atk: 8,
  def: 1,
}

player = {
  hp: 100,
  atk: 0,
  def: 0,
}

weap = [
  [:dagger, 8, 4, 0],
  [:short, 10, 5, 0],
  [:hammer, 25, 6, 0],
  [:long, 40, 7, 0],
  [:axe, 74, 8, 0],
]

arm = [
  [nil, 0, 0, 0],
  [:leather, 13, 0, 1],
  [:chain, 31, 0, 2],
  [:splint, 53, 0, 3],
  [:banded, 75, 0, 4],
  [:plate, 102, 0, 5],
]

ring = [
  [nil, 0, 0, 0],
  [nil, 0, 0, 0],
  [:atk1, 25, 1, 0],
  [:atk2, 50, 2, 0],
  [:atk3, 100, 3, 0],
  [:def1, 20, 0, 1],
  [:def2, 40, 0, 2],
  [:def3, 80, 0, 3],
]

puts 78 # Worked out in head, exact match stats cheapest

# Part 2
mob = {
  hp: 104,
  atk: 8,
  def: 1,
}

player = {
  hp: 100,
  atk: 0,
  def: 0,
}

weap = [
  [:dagger, 8, 4, 0],
  [:short, 10, 5, 0],
  [:hammer, 25, 6, 0],
  [:long, 40, 7, 0],
  [:axe, 74, 8, 0],
]

arm = [
  [nil, 0, 0, 0],
  [:leather, 13, 0, 1],
  [:chain, 31, 0, 2],
  [:splint, 53, 0, 3],
  [:banded, 75, 0, 4],
  [:plate, 102, 0, 5],
]

ring = [
  [nil, 0, 0, 0],
  [nil, 0, 0, 0],
  [:atk1, 25, 1, 0],
  [:atk2, 50, 2, 0],
  [:atk3, 100, 3, 0],
  [:def1, 20, 0, 1],
  [:def2, 40, 0, 2],
  [:def3, 80, 0, 3],
]

max = 0
weap.each do |w|
  arm.each do |a|
    ring.size.times do |r1i|
      ((r1i + 1)...ring.size).each do |r2i|
        equip = [w, a, ring[r1i], ring[r2i]]
        cost = equip.map { |i| i[1] }.inject(&:+)
        next if cost < max

        hero = player.dup
        hero[:atk] += equip.map { |i| i[2] }.inject(&:+)
        hero[:def] += equip.map { |i| i[3] }.inject(&:+)
        boss = mob.dup

        loop do
          boss[:hp] -= [1, hero[:atk] - boss[:def]].max
          break if boss[:hp] <= 0
          hero[:hp] -= [1, boss[:atk] - hero[:def]].max
          break if hero[:hp] <= 0
        end

        if boss[:hp] > 0
          max = cost
          # p [cost, boss, hero, equip]
        end
      end
    end
  end
end

puts max
