require 'digest'
input = "bgvyzdsv"

i = 0
loop do
  i += 1
  if Digest::MD5.hexdigest(input+i.to_s) =~ /^00000/
    puts i
    exit
  end
end
require 'digest'
input = "bgvyzdsv"

i = 0
loop do
  i += 1
  if Digest::MD5.hexdigest(input+i.to_s) =~ /^000000/
    puts i
    exit
  end
end
