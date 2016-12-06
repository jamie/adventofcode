kit = {}

File.read('input').each_line do |line|
  line =~ /(.*) -> (.*)/
  gate, wire = $1, $2
  kit[wire] = gate
end
kit['b'] = 3176

MASK = 0b1111_1111_1111_1111
def eval(kit, gate)
  value = case gate
  when Numeric
    gate
  when /^(\d+)$/
    $1.to_i
  when /^NOT (.+)$/
    MASK ^ eval(kit, $1)
  when /^(.+) AND (.+)$/
    eval(kit, $1) & eval(kit, $2)
  when /^(.+) OR (.+)$/
    eval(kit, $1) | eval(kit, $2)
  when /^(.+) LSHIFT (.+)$/
    (eval(kit, $1) << eval(kit, $2)) & MASK
  when /^(.+) RSHIFT (.+)$/
    (eval(kit, $1) >> eval(kit, $2)) & MASK
  else
    kit[gate] = eval(kit, kit[gate])
  end
  value
end

puts eval(kit, 'a')