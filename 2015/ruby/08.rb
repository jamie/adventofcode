diff = 0
File.read('input').split("\n").each do |line|
  diff += line.length - eval(line).length
end
puts diff
diff = 0
File.read('input').split("\n").each do |line|
  diff += line.inspect.length - line.length
end
puts diff
