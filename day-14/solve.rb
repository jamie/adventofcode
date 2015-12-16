reindeer = []
race_time = 2503

File.read('input').each_line do |line|
  line =~ /(.*) can fly (.*) km\/s for (.*) seconds, but then must rest for (.*) seconds./
  reindeer << Regexp.last_match.captures.map{|val| val =~ /\d/ ? val.to_i : val}
end

reindeer.each do |deer|
  name, speed, endurance, recovery = deer

  distance = 0
  time = 0
  while (time+endurance) < race_time do
    time += endurance
    distance += speed * endurance
    time += recovery
  end
  while time < race_time do
    time += 1
    distance += speed
  end

  deer << distance
end

puts reindeer.sort_by(&:last).last.last
