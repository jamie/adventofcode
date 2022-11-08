require "advent"
input = Advent.input

# Part 1
kit = {}

input.each do |line|
  line =~ /(.*) -> (.*)/
  gate, wire = Regexp.last_match(1), Regexp.last_match(2)
  kit[wire] = gate
end

MASK = 0b1111_1111_1111_1111

def eval(kit, gate)
  case gate
  when Numeric
    gate
  when /^(\d+)$/
    Regexp.last_match(1).to_i
  when /^NOT (.+)$/
    MASK ^ eval(kit, Regexp.last_match(1))
  when /^(.+) AND (.+)$/
    eval(kit, Regexp.last_match(1)) & eval(kit, Regexp.last_match(2))
  when /^(.+) OR (.+)$/
    eval(kit, Regexp.last_match(1)) | eval(kit, Regexp.last_match(2))
  when /^(.+) LSHIFT (.+)$/
    (eval(kit, Regexp.last_match(1)) << eval(kit, Regexp.last_match(2))) & MASK
  when /^(.+) RSHIFT (.+)$/
    (eval(kit, Regexp.last_match(1)) >> eval(kit, Regexp.last_match(2))) & MASK
  else
    kit[gate] = eval(kit, kit[gate])
  end
end

puts eval(kit, "a")

# Part 2
kit = {}
input.each do |line|
  line =~ /(.*) -> (.*)/
  gate, wire = Regexp.last_match(1), Regexp.last_match(2)
  kit[wire] = gate
end
kit["b"] = 3176

puts eval(kit, "a")
