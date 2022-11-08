require "advent"
input = Advent.input

# Part 1
asteroids = []

input.each_with_index do |row, y|
  row.split("").each_with_index do |cell, x|
    asteroids << [x, y] if cell == "#"
  end
end

visibility = {}

asteroids.each do |x, y|
  vis = []
  visibility[[x, y]] = vis
  (asteroids - [[x, y]]).each do |x2, y2|
    vis << Math.atan2(y2 - y, x2 - x).round(6)
  end
end

max = visibility.values.map(&:uniq).map(&:size).max
puts max

# Part 2
laser = visibility.keys.detect { |key| visibility[key].uniq.size == max }

shots = {}
x, y = laser
(asteroids - [laser]).each do |x2, y2|
  dy = y - y2
  dx = x2 - x
  angle = Math.atan2(dy, dx).round(6)
  dist = Math.sqrt(dx * dx + dy * dy).round(6)
  shots[angle] ||= []
  shots[angle] << [dist, x2, y2]
  shots[angle].sort!
end

angles = shots.keys.sort.reverse
shot_index = angles.index(angles.detect { |angle| angle < Math::PI / 2 })

shot = nil
200.times do |i|
  loop do
    angle = angles[shot_index]
    shot = shots[angle].shift
    break if shot
  end
  shot_index += 1
  shot_index %= angles.size
  # puts "asteroid #{i+1} is at #{shot.inspect}"
end
puts shot[1] * 100 + shot[2]
