require "advent"
input = Advent.input(2015, 15)

# Part 1
ingredients = input.map { |line|
  line =~ /(.*): capacity (.*), durability (.*), flavor (.*), texture (.*), calories (.*)/
  [
    $2.to_i,
    $3.to_i,
    $4.to_i,
    $5.to_i,
  ]
}

max = 0

100.downto(0) do |i|
  (100 - i).downto(0) do |j|
    (100 - i - j).downto(0) do |k|
      l = 100 - i - j - k
      amounts = [i, j, k, l]
      values = ingredients.zip(amounts).map { |ing, amt|
        ing.map { |value| value * amt }
      }
      total_value = values.transpose.map { |properties| [properties.inject(&:+), 0].max }.inject(&:*)
      if total_value > max
        max = total_value
      end
    end
  end
end

puts max

# Part 2
ingredients = input.map { |line|
  line =~ /(.*): capacity (.*), durability (.*), flavor (.*), texture (.*), calories (.*)/
  [
    $2.to_i,
    $3.to_i,
    $4.to_i,
    $5.to_i,
    $6.to_i,
  ]
}

max = 0

100.downto(0) do |i|
  (100 - i).downto(0) do |j|
    (100 - i - j).downto(0) do |k|
      l = 100 - i - j - k
      amounts = [i, j, k, l]
      values = ingredients.zip(amounts).map { |ing, amt|
        ing.map { |value| value * amt }
      }
      property_values = values.transpose.map { |properties| [properties.inject(&:+), 0].max }
      total_value = property_values[0..3].inject(&:*)
      if total_value > max && property_values[4] == 500
        max = total_value
      end
    end
  end
end

puts max
