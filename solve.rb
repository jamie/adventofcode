year, day = ARGV
# If no year, assume latest
year, day = nil, year if year.to_i < 2000
year = Dir["20*"].last if year.nil?
# If no day, make wildcard
day = "0#{day}" if day && day.to_i < 10
day = "*" if day.nil?

Dir["#{year}/day-#{day}.rb"].each do |script|
  path, file = script.split("/")

  Dir.chdir path
  start = Time.now
  solution, solution2 = `ruby #{file}`.chomp.split("\n")
  stop = Time.now
  Dir.chdir '..'

  puts "%s %10s %10s (%5.2fs)" % [script, solution, solution2, (stop-start)]
end
