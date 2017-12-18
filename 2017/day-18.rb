input = File.readlines('input/18')

registers = Hash.new{0}

def value(val, registers)
  (val =~ /[0-9]/ ? val.to_i : registers[val])
end

index = 0
output = nil
loop do
  statement = input[index]
  index += 1
  case statement
  when /snd (.)/
    val = $1
    output = registers[val]
  
  when /set (.) (.+)/
    reg, val = $1, $2
    registers[reg] = value(val, registers)

  when /add (.) (.+)/
    reg, val = $1, $2
    registers[reg] += value(val, registers)
  
  when /mul (.) (.+)/
    reg, val = $1, $2
    registers[reg] *= value(val, registers)
  
  when /mod (.) (.+)/
    reg, val = $1, $2
    registers[reg] %= value(val, registers)
  
  when /rcv (.)/
    val = value($1, registers)
    if val != 0
      puts output
      exit
    end
  
  when /jgz (.) (.+)/
    val, off = $1, $2
    if value(val, registers) > 0
      index += value(off, registers) - 1
    end
  
  else
    puts "Unknown instruction: #{input[index]}"
    exit
  end
end
