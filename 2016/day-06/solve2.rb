word = File.readlines('input').map(&:chomp).map{|line|
  line.split(//)
}.transpose.map{|place|
  place.group_by{|e| e}.sort_by{|k,v| v.size}.first.first
}

puts word.join
