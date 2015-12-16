total_ribbon = 0

File.read('input').each_line do |line|
  x, y, z = line.chomp.split('x').map(&:to_i)

  total_ribbon += [x,y,z].sort[0..1].inject(&:+) * 2
  total_ribbon += x*y*z # Bow
end

puts total_ribbon
