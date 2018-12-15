require 'pp'
require 'time'
require 'date'

module Advent
  def self.input(year, day, format=:to_s)
    File.read('%4d/input/%02d' % [year, day]).chomp.split("\n").map(&format)
  end
end

class Node
  attr_accessor :value, :left, :right
  def initialize(value, left=nil, right=nil)
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

require 'forwardable'
class LinkedList
  extend Forwardable
  def_delegators :@cursor, :value, :left, :right
  attr_reader :cursor

  def initialize(initial_node=nil)
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
