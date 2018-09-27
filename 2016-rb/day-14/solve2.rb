require 'digest'

SALT = "ngcjuoqr"

trips = {}
keys = []

i = 0
loop do
  hash = Digest::MD5.hexdigest(SALT + i.to_s)
  2016.times { hash = Digest::MD5.hexdigest(hash) }
  if hash =~ /((.)\2\2\2\2)/
    trips[$2] ||= []
    keys += trips[$2].select{|j| ((i-1000)...i).include? j}
    if keys.uniq.size > 80
      puts keys.uniq.sort[63]
      exit
    end
  end
  if hash =~ /((.)\2\2)/
    trips[$2] ||= []
    trips[$2] << i
  end
  i += 1
end
