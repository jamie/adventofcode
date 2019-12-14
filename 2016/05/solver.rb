require "advent"
input = Advent.input()

# Parts 1 and 2 require ~1m and 2.5m iterations,
# calculations merged to avoid a bunch of duplicate work
password = ""
password2 = []
password2_chars = 0

i = 0
while password.size < 8 || password2_chars < 8
  digest = Digest::MD5.new.hexdigest(input + i.to_s)
  if digest =~ /^00000(.)/
    password << Regexp.last_match(1)
  end
  if digest =~ /^00000([0-7])(.)/ && password2[Regexp.last_match(1).to_i].nil?
    password2[Regexp.last_match(1).to_i] = Regexp.last_match(2)
    password2_chars += 1
  end
  i += 1
end

puts password
puts password2.join
