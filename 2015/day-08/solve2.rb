diff = 0
File.read('input').split("\n").each do |line|
  diff += line.inspect.length - line.length
end
puts diff
