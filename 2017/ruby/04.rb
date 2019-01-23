require 'advent'
input = Advent.input(2017, 4)

input.select {|line|
  words = line.split(/ +/)
  words.size == words.uniq.size
}.tap{|valid| puts valid.size }

input.select {|line|
  words = line.split(/ +/)
  words.map!{|word| word.split(//).sort.join}
  words.size == words.uniq.size
}.tap{|valid| puts valid.size }
