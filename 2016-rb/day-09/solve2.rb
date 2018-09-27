input = "(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN"
input = File.read('input')

slices = input.scan(/[A-Z]+|\(\d+x\d+\)/)

def count_all(slices)
  length = 0

  while !slices.empty?
    puts slices.size if rand(2000).zero?

    slice = slices.shift
    if slice =~ /^\((\d+)x(\d+)\)/
      chars, count = $1.to_i, $2.to_i
      repeat = []
      while repeat.join.size < chars
        repeat << slices.shift
      end
      if repeat.join.size > chars
        overlap = repeat.join.size - chars
        straddle = repeat.pop
        repeat << straddle[0...-overlap]
        slices.unshift straddle[-overlap..-1]
      end
      length += count_all(repeat) * count
    else
      length += slice.size
    end
  end

  length
end

puts count_all(slices)
