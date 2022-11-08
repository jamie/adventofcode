require "advent"
input = Advent.input

require "knothash"

class KnotHash
  def bitdigest
    digest.pack("C*").unpack1("B*") # <- voodoo
  end
end

bitmaps = (0...128).map do |row|
  lengths = "#{input}-#{row}".bytes

  knot = KnotHash.new(lengths)
  knot.bitdigest
end

# Part 1: count the on bits
puts bitmaps.map { |str| str.split("").select { |b| b == "1" }.size }.inject(&:+)

# Part 2: count orthogonally-connected bit groups, by flipping their bits to 0
regions = 0
until bitmaps.empty?
  cells = [[0, bitmaps[0].index("1")]]
  until cells.empty?
    row, col = cells.shift
    cells << [row - 1, col] if row > 0 && bitmaps[row - 1] && bitmaps[row - 1][col] == "1"
    cells << [row + 1, col] if row < 128 && bitmaps[row + 1] && bitmaps[row + 1][col] == "1"
    cells << [row, col - 1] if col > 0 && bitmaps[row] && bitmaps[row][col - 1] == "1"
    cells << [row, col + 1] if col < 128 && bitmaps[row] && bitmaps[row][col + 1] == "1"
    bitmaps[row][col] = "0"
  end

  regions += 1
  bitmaps.shift while bitmaps[0] =~ /^0+$/
end
puts regions
