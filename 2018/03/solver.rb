require "advent"
input = Advent.input

area = Hash.new { |h, k| h[k] = 0 }

input.each do |line|
  # 1 @ 126,902: 29x28
  # 2 @ 84,482: 15x11
  x, y, w, h = line.match(/(\d+),(\d+): (\d+)x(\d+)/).captures.map(&:to_i)
  w.times do |i|
    h.times do |j|
      area[[x + i, y + j]] += 1
    end
  end
end

puts area.values.select { |v| v > 1 }.count

input.each do |line|
  # 1 @ 126,902: 29x28
  # 2 @ 84,482: 15x11
  id, x, y, w, h = line.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).captures.map(&:to_i)
  patch = []
  w.times do |i|
    h.times do |j|
      patch << area[[x + i, y + j]]
    end
  end
  puts id if patch.uniq == [1]
end
