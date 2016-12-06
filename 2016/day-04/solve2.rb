File.readlines('input').map do |line|
  name_enc, sector, checksum = line.scan(/([a-z-]+)-([\d]+)\[([a-z]{5})\]/)[0]

  rot = sector.to_i % 26
  a = 97

  name = name_enc.tr(('a'..'z').to_a.join, (((a+rot).chr .. 'z').to_a+('a' .. (a+rot-1).chr).to_a).join )
  puts sector if name == 'northpole-object-storage'
end

