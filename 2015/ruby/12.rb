json = File.read('input')

puts json.scan(/-?\d+/).map(&:to_i).inject(&:+)
require 'json'
json = File.read('input')
data = JSON.parse(json)

def score(node)
  case node
  when String; 0
  when Numeric; node
  when Array
    node.map{|val| score(val)}.inject(&:+)
  when Hash
    if node.values.any?{|val| val == "red"}
      0
    else
      score(node.values)
    end
  end
end

puts score(data)
