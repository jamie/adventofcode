input = File.readlines('input')

medicine = input.pop
transforms = input.inject({}) do |h, line|
  src, dst = line.chomp.split(" => ")
  fail if h[dst]
  h[dst] = src
  h
end

def dig(depth, current, transforms)
  transforms.each do |src, dst|
    parts = (current+'.').split(src)
    (parts.size-1).times do |i|
      lead = parts[0..i].join(src)
      tail = parts[(i+1)..(parts.size)].join(src)
      sample = lead + dst + tail.chomp('.')

      if sample == 'e'
        puts depth+1
        exit
      end

      next if dst == 'e'

      dig(depth+1, sample, transforms)
    end
  end
end

dig(0, medicine, transforms)

