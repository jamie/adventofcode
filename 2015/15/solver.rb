require "advent"
input = Advent.input

# Part 1
ingredients = input.map do |line|
  line =~ /(.*): capacity (.*), durability (.*), flavor (.*), texture (.*), calories (.*)/
  [
    Regexp.last_match(2).to_i,
    Regexp.last_match(3).to_i,
    Regexp.last_match(4).to_i,
    Regexp.last_match(5).to_i,
  ]
end

max = 0

100.downto(0) do |i|
  (100 - i).downto(0) do |j|
    (100 - i - j).downto(0) do |k|
      l = 100 - i - j - k
      amounts = [i, j, k, l]
      values = ingredients.zip(amounts).map do |ing, amt|
        ing.map { |value| value * amt }
      end
      total_value = values.transpose.map { |properties| [properties.inject(&:+), 0].max }.inject(&:*)
      if total_value > max
        max = total_value
      end
    end
  end
end

puts max

# Part 2
ingredients = input.map do |line|
  line =~ /(.*): capacity (.*), durability (.*), flavor (.*), texture (.*), calories (.*)/
  [
    Regexp.last_match(2).to_i,
    Regexp.last_match(3).to_i,
    Regexp.last_match(4).to_i,
    Regexp.last_match(5).to_i,
    Regexp.last_match(6).to_i,
  ]
end

max = 0

100.downto(0) do |i|
  (100 - i).downto(0) do |j|
    (100 - i - j).downto(0) do |k|
      l = 100 - i - j - k
      amounts = [i, j, k, l]
      values = ingredients.zip(amounts).map do |ing, amt|
        ing.map { |value| value * amt }
      end
      property_values = values.transpose.map { |properties| [properties.inject(&:+), 0].max }
      total_value = property_values[0..3].inject(&:*)
      if total_value > max && property_values[4] == 500
        max = total_value
      end
    end
  end
end

puts max
