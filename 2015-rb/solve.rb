Dir["*/solve.rb"].each do |solver|
  path, script = solver.split("/")
  Dir.chdir path
  start = Time.now
  solution, solution2 = `ruby solve.rb`.chomp.split("\n")
  solution2 = `ruby solve2.rb`.chomp if File.exist?('solve2.rb')
  stop = Time.now
  Dir.chdir '..'

  puts "%s: %8s %8s (%5.2fs)" % [path, solution, solution2, (stop-start)]
end
