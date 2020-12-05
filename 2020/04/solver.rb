require "advent"
input = Advent.input.join("\n").split("\n\n")

inxput = <<STR.split("\n\n")
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
STR

fields = %w(byr iyr eyr hgt hcl ecl pid) # cid ignored for both

# Part 1
x = 0
input.each do |entry|
  x += 1 if fields.all?{|f| entry.include?("#{f}:")}
end
puts x

# Part 2
x = 0
input.each do |entry|
  if fields.all?{|f| entry.include?("#{f}:")}
    next unless entry =~ /byr:(\d{4})/ && (1920..2002).include?($1.to_i)
    next unless entry =~ /iyr:(\d{4})/ && (2010..2020).include?($1.to_i)
    next unless entry =~ /eyr:(\d{4})/ && (2020..2030).include?($1.to_i)
    
    if entry =~ /cm/
      next unless entry =~ /hgt:(\d+)cm/ && (150..193).include?($1.to_i)
    else
      next unless entry =~ /hgt:(\d+)in/ && (59..76).include?($1.to_i)
    end

    next unless entry =~ /hcl:#[0-9a-f]{6}\b/
    next unless entry =~ /ecl:(amb|blu|brn|gry|grn|hzl|oth)\b/
    next unless entry =~ /pid:[0-9]{9}\b/

    x += 1
  end
end
puts x
