require "advent"
input = Advent.input

fields = input[0..19]
my_ticket = input[22].split(",").map(&:to_i)
tickets = input[25..-1].map { |line| line.split(",").map(&:to_i) }

field_ranges = {}
fields.each do |field|
  field =~ /(.*): (.*)-(.*) or (.*)-(.*)/
  name = $1
  range1 = ($2.to_i)..($3.to_i)
  range2 = ($4.to_i)..($5.to_i)

  field_ranges[name] = [range1, range2]
end

all_ranges = field_ranges.values.flatten
errors = []
invalid = []
tickets.each do |ticket|
  ticket.each do |value|
    unless all_ranges.any? { |r| r.include?(value) }
      errors << value
      invalid << ticket # Part 2 setup
    end
  end
end
puts errors.sum

# Part 2

tickets -= invalid
mappings = {}
field_ranges.each do |name, ranges|
  (tickets + [my_ticket]).transpose.each.with_index do |values, i|
    if values.all? { |v| ranges.any? { |r| r.include?(v) } }
      mappings[name] ||= []
      mappings[name] << i
    end
  end
end

loop do
  mappings.each do |field, values|
    if values.size == 1
      mappings.each do |f, v|
        next if field == f
        v.delete(values[0])
      end
    end
  end
  break if mappings.values.all? { |v| v.size == 1 }
end

my_values = mappings.map do |field, values|
  my_ticket[values[0]] if /departure/.match?(field)
end
puts my_values.compact.inject(&:*)
