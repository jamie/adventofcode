require "pp"
require "time"
require "date"
require "digest"

require "linked_list"
require "priority_deque"

module Advent
  def self.input(year, day, format = :to_s)
    infile = "%4d/%02d/input" % [year, day]
    if !File.exist?(infile)
      puts "No input file #{infile}"
      exit
    end
    out = File.readlines(infile).map(&:chomp).map(&format)
    return out[0] if out.size == 1
    out
  end
end
