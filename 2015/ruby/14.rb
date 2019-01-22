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
reindeer = []
race_time = 2503

File.read('input').each_line do |line|
  line =~ /(.*) can fly (.*) km\/s for (.*) seconds, but then must rest for (.*) seconds./
  reindeer << {
    name:      $1,
    speed:     $2.to_i,
    endurance: $3.to_i,
    recovery:  $4.to_i,
    location:  0,
    points:    0,
  }
end

reindeer.each do |deer|
  deer[:activity] = [:fly] * deer[:endurance] + [:rest] * deer[:recovery]
end

2503.times do
  reindeer.each do |deer|
    action = deer[:activity].shift
    deer[:location] += deer[:speed] if action == :fly
    deer[:activity] << action
  end
  reindeer.sort_by{|deer| deer[:location]}.last[:points] += 1
end

puts reindeer.map{|deer| deer[:points]}.sort.last
