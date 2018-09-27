nice = 0

File.read('input').chomp.split("\n").each do |string|
  if string =~ /(..).*\1/
    if string =~ /(.).\1/
      nice += 1
    end
  end
end

puts nice
