require 'pp'
require 'time'
require 'date'

module Advent
  def self.input(year, day, format=:to_s)
    File.read('%4d/input/%02d' % [year, day]).chomp.split("\n").map(&format)
  end
end
