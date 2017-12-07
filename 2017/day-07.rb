input = File.readlines('input/07')

parents = {}
childrens = {}
weights = {}
input.each do |entry|
  entry =~ /(.*) \((\d+)\)( -> (.*))?/
  parent, weight, children = $1, $2, $4
  weights[parent] = weight.to_i
  if children
    childrens[parent] = children.split(", ")
    children.split(", ").each do |child|
      parents[child] = parent
    end
  end
end

node = parents.keys.first
node = parents[node] while parents[node]
root = node
puts root

def check_weight(node, childrens, weights)
  childs = childrens[node]
  return weights[node] if childs.nil?
  child_weights = {}
  childs.map do |child|
    child_weights[child] = check_weight(child, childrens, weights)
  end
  if child_weights.values.uniq.size > 1
    heavy_child = child_weights.key(child_weights.values.max)
    overweight = child_weights.values.max - child_weights.values.min
    puts weights[heavy_child] - overweight
    exit
  end
  
  weights[node] + child_weights.values.inject(&:+)
end
check_weight(root, childrens, weights)


