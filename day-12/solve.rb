json = File.read('input')

puts json.scan(/-?\d+/).map(&:to_i).inject(&:+)
