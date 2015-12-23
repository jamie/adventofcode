r = {'a'=>0, 'b'=>0}

code = File.readlines('input').map(&:chomp)

i = 0

loop do
  break unless code[i]
  parts = code[i].split(/,? /)
  case code[i]
  when /hlf/; r[parts[1]] /= 2; i += 1
  when /tpl/; r[parts[1]] *= 3; i += 1
  when /inc/; r[parts[1]] += 1; i += 1
  when /jmp/; i += parts[1].to_i
  when /jie/; i += (r[parts[1]].even? ? parts[2].to_i : 1)
  when /jio/; i += (r[parts[1]] == 1  ? parts[2].to_i : 1)
  else
    fail "Unhandled: #{parts.inspect}"
  end
end

puts r['b']
