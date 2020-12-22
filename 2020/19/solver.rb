require "advent"
input = Advent.input

message_rules = input[0...134]
messages = input[135...-1]

xmessage_rules = <<STR.split("\n")
0: 4 1 5
1: 2 3 | 3 2
2: 4 4 | 5 5
3: 4 5 | 5 4
4: "a"
5: "b"
STR
xmessages = <<STR.split("\n")
ababbb
bababa
abbbab
aaabbb
aaaabbb
STR

rules = {}
message_rules.sort.each do |rule_str|
  if rule_str =~ /(\d+): (\d+) (\d+) \| (\d+) (\d+)$/
    rules[$1.to_i] = [[$2.to_i, $3.to_i], [$4.to_i, $5.to_i]]
  elsif rule_str =~ /(\d+): (\d+) (\d+) (\d+)$/
    rules[$1.to_i] = [[$2.to_i, $3.to_i, $4.to_i]]
  elsif rule_str =~ /(\d+): (\d+) (\d+)$/
    rules[$1.to_i] = [[$2.to_i, $3.to_i]]
  elsif rule_str =~ /(\d+): (\d+) \| (\d+)$/
    rules[$1.to_i] = [[$2.to_i], [$3.to_i]]
  elsif rule_str =~ /(\d+): (\d+)$/
    rules[$1.to_i] = [[$2.to_i]]
  elsif rule_str =~ /(\d+): "(.)"$/
    rules[$1.to_i] = $2
  else
    raise "Parse error: #{rule_str}"
  end
end

loop do
  size = rules.size

  rules.keys.each do |key|
    if rules[key].is_a? String
      value = rules.delete(key)
      rules.each do |kar, var|
        next if var.kind_of? String
        var.each.with_index do |va, ia|
          next if va.kind_of? String
          va.each.with_index do |v, i|
            va[i] = value if v == key
          end
          if va.all?{|v| v.kind_of? String}
            var[ia] = va.join
          end
        end
        if var.all?{|v| v.kind_of? String}
          if var.size == 1
            rules[kar] = var[0]
          else
            rules[kar] = "(#{var.join("|")})"
          end
        end
      end
    end
  end

  break if rules.size == size
  break if rules.size == 1
end

pattern = Regexp.new("^(#{rules[0]})$")
# puts pattern

puts messages.count{|message| message =~ pattern}

# Part 2

rules = {}
message_rules.sort.each do |rule_str|
  if rule_str =~ /(\d+): (\d+) (\d+) \| (\d+) (\d+)$/
    rules[$1.to_i] = [[$2.to_i, $3.to_i], [$4.to_i, $5.to_i]]
  elsif rule_str =~ /(\d+): (\d+) (\d+) (\d+)$/
    rules[$1.to_i] = [[$2.to_i, $3.to_i, $4.to_i]]
  elsif rule_str =~ /(\d+): (\d+) (\d+)$/
    rules[$1.to_i] = [[$2.to_i, $3.to_i]]
  elsif rule_str =~ /(\d+): (\d+) \| (\d+)$/
    rules[$1.to_i] = [[$2.to_i], [$3.to_i]]
  elsif rule_str =~ /(\d+): (\d+)$/
    rules[$1.to_i] = [[$2.to_i]]
  elsif rule_str =~ /(\d+): "(.)"$/
    rules[$1.to_i] = $2
  else
    raise "Parse error: #{rule_str}"
  end
end

# Clean up primary + recursive
rules.delete(0) # 8 11
rules.delete(8) # 42 | 42 8
rules.delete(11) # 42 31 | 42 11 31

loop do
  size = rules.size

  rules.keys.each do |key|
    next if [0, 8, 11, 31, 42].include?(key) # Specials
    if rules[key].is_a? String
      value = rules.delete(key)
      rules.each do |kar, var|
        next if var.kind_of? String
        var.each.with_index do |va, ia|
          next if va.kind_of? String
          va.each.with_index do |v, i|
            va[i] = value if v == key
          end
          if va.all?{|v| v.kind_of? String}
            var[ia] = va.join
          end
        end
        if var.all?{|v| v.kind_of? String}
          if var.size == 1
            rules[kar] = var[0]
          else
            rules[kar] = "(#{var.join("|")})"
          end
        end
      end
    end
  end

  break if rules.size == size
end

# reassemble pattern manually, nesting recursion 5x

r42 = rules[42]
r31 = rules[31]

r8a = "(#{r42})"
r8b = "(#{r42}|#{r42+r8a})"
r8c = "(#{r42}|#{r42+r8b})"
r8d = "(#{r42}|#{r42+r8c})"
r8e = "(#{r42}|#{r42+r8d})"

r11a = "(#{r42}#{r31})"
r11b = "(#{r42}#{r31}|#{r42}#{r11a}#{r31})"
r11c = "(#{r42}#{r31}|#{r42}#{r11b}#{r31})"
r11d = "(#{r42}#{r31}|#{r42}#{r11c}#{r31})"
r11e = "(#{r42}#{r31}|#{r42}#{r11d}#{r31})"

r0 = "(#{r8e}#{r11e})"

pattern = Regexp.new("^#{r0}$")
# puts pattern

puts messages.count{|message| message =~ pattern}
