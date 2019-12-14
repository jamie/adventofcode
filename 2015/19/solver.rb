require "advent"
input = Advent.input

# Part 1
molecule = input.pop
transforms = input.inject({}) do |h, line|
  src, dst = line.chomp.split(" => ")
  h[src] ||= []
  h[src] << dst
  h
end

transformed = []

atoms = molecule.scan(/[A-Z][a-z]?/)
atoms.size.times do |i|
  next if transforms[atoms[i]].nil?
  transforms[atoms[i]].each do |new_atom|
    transformed << (atoms[0...i] + [new_atom] + atoms[i + 1...atoms.size]).join
  end
end

p transformed.uniq.size

# Part 2
transforms = input.inject({}) do |h, line|
  src, dst = line.chomp.split(" => ")
  fail if h[dst]
  h[dst] = src
  h
end

def dig(depth, current, transforms)
  transforms.each do |src, dst|
    parts = (current + ".").split(src)
    (parts.size - 1).times do |i|
      lead = parts[0..i].join(src)
      tail = parts[(i + 1)..(parts.size)].join(src)
      sample = lead + dst + tail.chomp(".")

      if sample == "e"
        puts depth + 1
        exit
      end

      next if dst == "e"

      dig(depth + 1, sample, transforms)
    end
  end
end

dig(0, molecule, transforms)
