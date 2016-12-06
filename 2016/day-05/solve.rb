require 'digest'

input = "ugkcyxxp"
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
