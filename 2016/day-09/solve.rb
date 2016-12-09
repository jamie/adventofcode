output = ""
input = File.read('input').chomp

i = 0
while i < input.size do
  chr = input[i]
  if chr == '('
    input[i..(i+20)] =~ /^(\((\d+)x(\d+)\))/
    skip = $1.size
    c, r = $2.to_i, $3.to_i
    substr = input[(i+skip)...(i+skip+c)]
    r.times { output << substr }
    i += skip + c
  else
    output << chr
    i += 1
  end
end

puts output.size
