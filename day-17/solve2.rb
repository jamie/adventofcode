containers = File.readlines('input').map(&:to_i).sort.reverse

total = 0
(1..containers.size).each do |count|
  containers.combination(count).to_a.each do |combination|
    total += 1 if combination.inject(&:+) == 150
  end
  break if total > 0
end
puts total

