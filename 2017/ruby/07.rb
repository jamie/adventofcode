require "advent"
input = Advent.input(2017, 7)

NTreeNode = Struct.new(:parent, :name, :weight, :children)
nodes = {}

# Parse input
input.each do |entry|
  entry =~ /(.*) \((\d+)\)( -> (.*))?/
  name, weight, children = Regexp.last_match(1), Regexp.last_match(2).to_i, Regexp.last_match(4)
  children = children.split(", ") if children

  node = NTreeNode.new(nil, name, weight, children)
  nodes[name] = node
end

# Link tree
nodes.each do |_, node|
  next if node.children.nil?
  node.children.map! do |child_name|
    child_node = nodes[child_name]
    child_node.parent = node
    child_node
  end
end

# Find root (Part One)
root_candidates = nodes.values.select { |node| node.parent.nil? }
fail "Multiple Roots" if root_candidates.size > 1 # sanity
root = root_candidates[0]
puts root.name

# Weigh tree (Part Two)
def check_weight(node)
  return node.weight if node.children.nil?

  weights = node.children.map { |c| check_weight(c) }
  if weights.uniq.size == 1
    return node.weight + weights.inject(&:+)
  else
    diff = weights.max - weights.min
    id = weights.index(weights.max)
    puts node.children[id].weight - diff
    exit
  end
end

check_weight(root)
