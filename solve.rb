Dir["*/solve.rb"].each do |solver|
  path, script = solver.split("/")
  Dir.chdir path
  start = Time.now
  solution = `ruby solve.rb`.chomp
  solution2 = File.exist?('solve2.rb') ? `ruby solve2.rb`.chomp : ''
  stop = Time.now
  Dir.chdir '..'

  puts "%s: %8s %8s (%5.2fs)" % [path, solution, solution2, (stop-start)]
end
