require 'pp'
require 'time'
require 'date'
require 'digest'

module Advent
  def self.input(year, day, format=:to_s)
    out = File.readlines('%4d/input/%02d' % [year, day]).map(&:chomp).map(&format)
    return out[0] if out.size == 1
    return out
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

class PriorityDeque
  attr_reader :queue
  def initialize
    @queue = {}
  end

  def add(priority, value)
    @queue[priority] ||= []
    @queue[priority] << value
  end

  def pop
    priority = @queue.keys.max
    value = @queue[priority].pop
    if @queue[priority].empty?
      @queue.delete(priority)
    end
    value
  end

  def shift
    priority = @queue.keys.max
    value = @queue[priority].shift
    if @queue[priority].empty?
      @queue.delete(priority)
    end
    value
  end

  def size
    @queue.values.sum(&:size)
  end
end
