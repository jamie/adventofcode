input = "197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63"

class KnotHash
  attr_reader :list, :lengths, :pos, :skip

  def initialize(list, lengths)
    @pos = 0
    @skip = 0
    @list = list
    @lengths = lengths
  end

  def run_round
    lengths.each do |length|
      i, j = pos, pos+length-1
      while i < j
        list[i%256], list[j%256] = list[j%256], list[i%256]
        i += 1
        j -= 1
      end
      @pos += length
      @pos += skip
      @skip += 1
    end
    list
  end

  def product
    list[0] * list[1]
  end

  def hash
    blocks = (0..15).map {|i| list[(i*16)..(i*16+15)].inject(&:^) }
    blocks.pack('C*').unpack('H*')[0] # <- voodoo
  end
end

lengths = input.split(',').map(&:to_i)
list = (0..255).to_a
knot = KnotHash.new(list, lengths)
knot.run_round
puts knot.product

lengths = input.bytes + [17, 31, 73, 47, 23]
list = (0..255).to_a
knot = KnotHash.new(list, lengths)
64.times { knot.run_round }
puts knot.hash
