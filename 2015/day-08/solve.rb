diff = 0
File.read('input').split("\n").each do |line|
  diff += line.length - eval(line).length
end
puts diff
