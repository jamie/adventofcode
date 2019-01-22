phrase = "3113322113"

50.times do |i|
  puts phrase.length if i == 40

  groups = phrase.scan(/((.)\2*)/).map(&:first)
  phrase = groups.map{|group| [group.length, group[0]] }.flatten.join
end

puts phrase.length