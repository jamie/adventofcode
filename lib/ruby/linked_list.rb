require "forwardable"
require "node"

class LinkedList
  extend Forwardable
  def_delegators :@cursor, :value, :left, :right
  attr_reader :cursor

  def initialize(initial_node = nil)
    @cursor = initial_node
  end

  def left!
    @cursor = @cursor.left
  end

  def right!
    @cursor = @cursor.right
  end

  def append!(value)
    if @cursor
      @cursor = @cursor.append(value)
    else
      @cursor = Node.new(value)
    end
  end

  def read(n)
    result = []
    c = @cursor
    while result.size < n
      result << c.value
      c = c.right
    end
    result
  end

  def clone!
    LinkedList.new(@cursor)
  end
end
