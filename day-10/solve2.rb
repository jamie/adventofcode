phrase = "3113322113"

50.times do
  groups = phrase.scan(/((.)\2*)/).map(&:first)
  phrase = groups.map{|group| [group.length, group[0]] }.flatten.join
end

puts phrase.length