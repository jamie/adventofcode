nice = 0

File.read('input').chomp.split("\n").each do |string|
  if string =~ /[aeiou].*[aeiou].*[aeiou]/
    if string =~ /(.)\1/
      if string !~ /ab|cd|pq|xy/
        nice += 1
      end
    end
  end
end

puts nice
nice = 0

File.read('input').chomp.split("\n").each do |string|
  if string =~ /(..).*\1/
    if string =~ /(.).\1/
      nice += 1
    end
  end
end

puts nice
