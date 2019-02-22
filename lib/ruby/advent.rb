require 'pp'
require 'time'
require 'date'
require 'digest'

require 'priority_queue'
require 'linked_list'

module Advent
  def self.input(year, day, format=:to_s)
    out = File.readlines('%4d/input/%02d' % [year, day]).map(&:chomp).map(&format)
    return out[0] if out.size == 1
    return out
  end
end
