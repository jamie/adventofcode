require "advent"
input = Advent.input()

# Part 1
trips = {}
keys = []

i = 0
loop do
  hash = Digest::MD5.hexdigest(input + i.to_s)
  if hash =~ /((.)\2\2\2\2)/
    trips[Regexp.last_match(2)] ||= []
    keys += trips[Regexp.last_match(2)].select { |j| ((i - 1000)...i).include? j }
    if keys.uniq.size > 64
      puts keys.uniq.sort[63]
      break
    end
  end
  if hash =~ /((.)\2\2)/
    trips[Regexp.last_match(2)] ||= []
    trips[Regexp.last_match(2)] << i
  end
  i += 1
end

# Part 2
trips = {}
keys = []

i = 0
loop do
  hash = Digest::MD5.hexdigest(input + i.to_s)
  2016.times { hash = Digest::MD5.hexdigest(hash) }
  if hash =~ /((.)\2\2\2\2)/
    trips[Regexp.last_match(2)] ||= []
    keys += trips[Regexp.last_match(2)].select { |j| ((i - 1000)...i).include? j }
    if keys.uniq.size > 80
      puts keys.uniq.sort[63]
      break
    end
  end
  if hash =~ /((.)\2\2)/
    trips[Regexp.last_match(2)] ||= []
    trips[Regexp.last_match(2)] << i
  end
  i += 1
end
