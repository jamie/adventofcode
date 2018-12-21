def run(r, seen)
  r[2] = r[5] | 65536 # 6
  r[5] = 7571367      # 7
  loop do
    r[4] = r[2] & 255 # 8
    r[5] += r[4]      # 9
    r[5] &= 16777215  # 10
    r[5] *= 65899     # 11
    r[5] &= 16777215  # 12
    if 256 > r[2]     # 13
      exit if (r[5] == r[0]) # 28-29
      if seen.include?(r[5])
        puts seen.last
        exit
      end
      seen << r[5]
      return          # 30
    end

    r[4] = 0 # 17
    loop do
      r[3] = r[4] + 1 # 18
      r[3] *= 256     # 19
      if r[3] > r[2]  # 20-21
        r[2] = r[4]   # 26
        break
      end
      r[4] += 1 # 24
    end
  end
end

r = [0,0,0,0,0,0]
seen = []

# Sanity check
r[5] = 123
loop do
  r[5] &= 456
  if r[5] == 72
    break
  end
end
r[5] = 0

loop do
  run(r, seen)
end
