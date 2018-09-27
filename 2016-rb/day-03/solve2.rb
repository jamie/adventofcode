input = File.readlines('input').map{|line| line.split(' ').map(&:to_i) }
triangles = input.each_slice(3).map(&:transpose).flatten(1)

possible = triangles.select do |triangle|
  triangle.permutation.all? do |a, b, c|
    a + b > c
  end
end
puts possible.size
