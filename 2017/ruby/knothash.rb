class KnotHash
  attr_reader :list, :lengths, :pos, :skip

  def initialize(lengths, salt = [17, 31, 73, 47, 23])
    @pos = 0
    @skip = 0
    @list = (0..255).to_a
    @lengths = lengths + salt

    @digest = nil
  end

  def digest
    if @digest.nil?
      run
      @digest = (0..15).map { |i| list[(i * 16)..(i * 16 + 15)].inject(&:^) }
    end
    @digest
  end

  def run
    64.times { run_round }
  end

  def run_round
    lengths.each do |length|
      i, j = pos, pos + length - 1
      while i < j
        list[i % list.size], list[j % list.size] = list[j % list.size], list[i % list.size]
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

  def hexdigest
    digest.pack("C*").unpack("H*")[0] # <- voodoo
  end
end
