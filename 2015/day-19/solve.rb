input = File.readlines('input')

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
    transformed << (atoms[0...i] + [new_atom] + atoms[i+1...atoms.size]).join
  end
end

p transformed.uniq.size
