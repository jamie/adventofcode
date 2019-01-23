require 'advent'
input = Advent.input(2016, 5)[0]

require 'digest'

# Part 1
password = ""

i = 0
while password.size < 8
  digest = Digest::MD5.new.hexdigest(input + i.to_s)
  if digest =~ /^00000(.)/
  	password << $1
  end
  i += 1
end

puts password

# Part 2
password = "________"

i = 0
c = 0
while c < 8
  digest = Digest::MD5.new.hexdigest(input + i.to_s)
  if digest =~ /^00000([0-7])(.)/ && password[$1.to_i] == '_'
  	password[$1.to_i] = $2
  	c += 1
  end
  i += 1
end

puts password
