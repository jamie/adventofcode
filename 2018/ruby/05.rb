require 'advent'
input = Advent.input(2018, 5)[0]

def squeeze!(input)
  ('a'..'z').each do |unit|
    a = input.gsub!("#{unit}#{unit.upcase}", "")
    b = input.gsub!("#{unit.upcase}#{unit}", "")
  end
end

def minimize(input)
  input = input.dup
  begin
    size = input.size
    squeeze!(input)
  end while size > input.size
  input
end

# Part 1
puts minimize(input).size

# Part 2
puts ('a'..'z').map{|bad| minimize(input.gsub(/#{bad}/i, '')).size }.min
