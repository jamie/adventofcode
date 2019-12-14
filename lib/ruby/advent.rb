require "pp"
require "time"
require "date"
require "digest"
require 'pathname'

require "linked_list"
require "priority_deque"

module Advent
  def self.input(format = :to_s)
    work_dir = Pathname.new(caller_locations.first.path).dirname
    infile = work_dir / 'input'

    if !File.exist?(infile)
      puts "No input file #{infile}"
      exit
    end
    out = File.readlines(infile).map(&:chomp).map(&format)
    return out[0] if out.size == 1
    out
  end
end
