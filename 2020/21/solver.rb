require "advent"
input = Advent.input

require 'set'
allergens = Set.new
ingredients = Set.new
products = []
allergen_map = {}

# Parse
input.each do |line|
  ing, all = line.chomp(")").split(" (contains ")

  this_ingredients = ing.split(" ")
  this_allergens = all.split(", ")
  
  ingredients += this_ingredients
  allergens += this_allergens

  products << [this_ingredients, this_allergens]
end

# Cross-reference
allergens.each do |allergen|
  reactive = products.select{|product| product.last.include?(allergen)}
  ing = reactive.map(&:first).inject(&:intersection)

  allergen_map[allergen] = ing
end

# Filter ambiguous
10.times do
  allergen_map.each do |k,v|
    if v.size == 1
      allergen_map[k] = v.first
      allergen_map.values.each {|val| val.delete(v.first) if val.is_a?(Array)}
    end
  end
end

puts (products.map(&:first).flatten - allergen_map.values).size

# Part 2
puts allergen_map.sort_by(&:first).map(&:last).join(',')
