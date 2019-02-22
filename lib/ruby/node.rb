class Node
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left || self
    @right = right || self
  end

  def delete
    left.right = right
    right.left = left
    [right, value]
  end

  def append(value)
    node = Node.new(value, self, right)
    self.right = node
    node.right.left = node
    node
  end
end
