password = "abcdefgh"

commands = File.readlines('input')

commands.each do |command|
  case command
  when /swap position (\d+) with position (\d+)/
    i, j = $1.to_i, $2.to_i
    password[i], password[j] = password[j], password[i]
  when /swap letter (.) with letter (.)/
    i, j = $1, $2
    password.tr!("#{i}#{j}", "#{j}#{i}")
  when /reverse positions (\d+) through (\d+)/
    i, j = $1.to_i, $2.to_i
    password[i..j] = password[i..j].reverse
  when /rotate left (\d+) step/
    i = $1.to_i
    substr = password[0...i]
    password.delete!(substr)
    password << substr
  when /rotate right (\d+) step/
    i = $1.to_i
    password = (password[-i..-1] + password)[0...-i] if i>0
  when /move position (\d+) to position (\d+)/
    i, j = $1.to_i, $2.to_i
    pass = password.split(//)
    char = pass.delete_at(i)
    pass.insert(j, char)
    password = pass.join
  when /rotate based on position of letter (.)/
    i = password.index($1)
    j = 1 + i + (i < 4 ? 0 : 1)
    j.times { password = (password[-1] + password)[0..-2] }
  end
end

puts password
