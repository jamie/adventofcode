require "advent"
input = Advent.input.map(&:to_i).sort

jolts = [0] + input + [input.max+3]

# Part 1

diff = [0, 0, 0, 0]
jolts.size.times do |i|
  next unless jolts[i+1]

  diff[jolts[i+1]-jolts[i]] += 1
end
puts diff[1] * diff[3]

# Part 2

perms = 1
chunks = jolts.chunk_while{ |x,y| y-x < 3}.to_a
chunks.each do |chunk|
  # Looking at live data + test data, values only diff by 1 or 3
  # So if we broke into chunks by 3, each chunk has values diff by 1
  # and we can do that math by hand.
  # In all cases, because first and last diff by 3 they must be kept
  case chunk.size
  when 1, 2
    # nop
  when 3 # 1,2,3; 1,3
    perms *= 2
  when 4 # 1,2,3,4; 1,3,4; 1,2,4; 1,4
    perms *= 4
  when 5 # 1,2,3,4,5; 1,3,4,5; 1,2,4,5; 1,2,3,5; 1,4,5; 1,2,5; 1,3,5
    perms *= 7
  end
end
puts perms
