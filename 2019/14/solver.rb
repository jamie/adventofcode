require "advent"
input = Advent.input

def convert(str)
  str =~ /(\d+) ([A-Z]+)/
  [$2, $1.to_i]
end

maps = {}
input.each do |line|
  inputs, output = line.split(" => ")
  inputs = inputs.split(", ")

  mat, qty = convert(output)
  reaction = [qty, inputs.map { |inp| convert(inp) }]
  maps[mat] = reaction
end

# Part 1
chems = { "FUEL" => 1 }
loop do
  prior_chems = chems.dup
  prior_chems.each do |mat, qty|
    reaction = maps[mat]
    next if reaction.nil?

    if qty > 0
      chems[mat] -= reaction[0]
      chems.delete(mat) if chems[mat] == 0

      reaction[1].each do |m, q|
        chems[m] ||= 0
        chems[m] += q
      end
    end
  end
  # pp chems
  break if chems == prior_chems
end
puts chems["ORE"]

# Part 2
fuel = Advent.rbsearch(1_000_000_000_000) do |f|
  chems = { "FUEL" => f }
  loop do
    prior_chems = chems.dup
    prior_chems.each do |mat, qty|
      reaction = maps[mat]
      next if reaction.nil?

      if qty >= reaction[0]
        mul = qty / reaction[0]
        mul += 1 unless mat == "FUEL"
        chems[mat] -= reaction[0] * mul

        reaction[1].each do |m, q|
          chems[m] ||= 0
          chems[m] += q * mul
        end
      end
    end
    break if chems == prior_chems
  end
  chems["ORE"]
end
puts fuel
