require 'advent'
input = Advent.input(2016, 21)

# Part 1
password = "abcdefgh"

def rotr(password, n)
  n = n % password.length
  return password if n.zero?
  password[-n..-1] + password[0...-n]
end

def rotl(password, n)
  n = n % password.length
  return password if n.zero?
  password[n..-1] + password[0...n]
end

input.each do |command|
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
  when /move position (\d+) to position (\d+)/
    i, j = $1.to_i, $2.to_i
    pass = password.split(//)
    char = pass.delete_at(i)
    pass.insert(j, char)
    password = pass.join
  when /rotate left (\d+) step/
    n = $1.to_i
    password = rotl(password, n)
  when /rotate right (\d+) step/
    n = $1.to_i
    password = rotr(password, n)
  when /rotate based on position of letter (.)/
    i = password.index($1)
    n = 1 + i + (i < 4 ? 0 : 1)
    password = rotr(password, n)
  end
end

puts password

# Part 2
password = "fbgdceah"

def rotr(password, n)
  n = n % password.length
  return password if n.zero?
  password[-n..-1] + password[0...-n]
end

def rotl(password, n)
  n = n % password.length
  return password if n.zero?
  password[n..-1] + password[0...n]
end

input.reverse.each do |command|
  # p [password, command]
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
  when /move position (\d+) to position (\d+)/
    j, i = $1.to_i, $2.to_i
    pass = password.split(//)
    char = pass.delete_at(i)
    pass.insert(j, char)
    password = pass.join
  when /rotate left (\d+) step/
    n = $1.to_i
    password = rotr(password, n)
  when /rotate right (\d+) step/
    n = $1.to_i
    password = rotl(password, n)
  when /rotate based on position of letter (.)/
    i = password.index($1)
    n = [1, 1, 6, 2, 7, 3, 0, 4][i] # mathed by hand
    password = rotl(password, n)
  end
end

puts password
