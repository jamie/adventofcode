Dir["*/solve.rb"].each do |solver|
  path, script = solver.split("/")
  Dir.chdir path
  solution = `ruby solve.rb`.chomp
  solution2 = File.exist?('solve2.rb') ? `ruby solve2.rb`.chomp : ''
  Dir.chdir '..'

  puts "%s: %8s %8s" % [path, solution, solution2]
end
