data = File.read('input')
ups = data.gsub(/[^(]/, '')
downs = data.gsub(/[^)]/, '')
puts ups.size - downs.size
