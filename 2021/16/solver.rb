require "advent"
input = Advent.input

def decode_packet(bits, offset = 0)
  version = bits[offset+0, 3].to_i(2)
  type_id = bits[offset+3, 3].to_i(2)
  bits_consumed = 6

  case type_id
  when 4 # Literal
    i = 6
    value = ''
    loop do
      bits_consumed += 5
      value << bits[offset+i+1, 4]
      break if bits[offset+i] == '0'
      i += 5
    end
    result = value.to_i(2)
  else # Operator
    length_type_id = bits[offset+6]
    if length_type_id == '0'
      length = bits[offset+7, 15].to_i(2)
      bits_consumed += 16

      result = []
      result_consumed = 0
      while result_consumed < length
        packet = decode_packet(bits, offset+bits_consumed+result_consumed)
        result << packet
        result_consumed += packet[:bits_consumed]
      end
    else # '1'
      subpackets = bits[offset+7, 11].to_i(2)
      bits_consumed += 12

      result = []
      result_consumed = 0
      subpackets.times do
        packet = decode_packet(bits, offset+bits_consumed+result_consumed)
        result << packet
        result_consumed += packet[:bits_consumed]
      end
    end
    bits_consumed += result_consumed
  end

  { version: version, type_id: type_id, value: result, bits_consumed: bits_consumed }
end

bits = input.to_i(16).to_s(2).rjust(input.size*4, '0')
sexp = decode_packet(bits)

# Part 1

def version_sum(sexp)
  sum = sexp[:version]
  if sexp[:value].is_a?(Array)
    sum += sexp[:value].map { |packet| version_sum(packet) }.sum
  end
  sum
end

puts version_sum(sexp)

# Part 2

def evaluate(sexp)
  case sexp[:type_id]
  when 0 # Sum
    values = sexp[:value].map { |value| evaluate(value) }
    values.inject(&:+)
  when 1 # Product
    values = sexp[:value].map { |value| evaluate(value) }
    values.inject(&:*)
  when 2 # Minimum
    values = sexp[:value].map { |value| evaluate(value) }
    values.min
  when 3 # Maximum
    values = sexp[:value].map { |value| evaluate(value) }
    values.max
  when 4 # Scalar value
    sexp[:value]
  when 5 # greater_than
    first, second = sexp[:value].map { |value| evaluate(value) }
    first > second ? 1 : 0
  when 6 # less_than
    first, second = sexp[:value].map { |value| evaluate(value) }
    first < second ? 1 : 0
  when 7 # equal
    first, second = sexp[:value].map { |value| evaluate(value) }
    first == second ? 1 : 0
  end
end

puts evaluate(sexp)
