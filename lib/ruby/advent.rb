require "pp"
require "time"
require "date"
require "debug"
require "digest"
require "pathname"

require "linked_list"
require "priority_deque"

DIRS = DIRS2D = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
DIRS3D = [-1, 0, 1].product([-1, 0, 1]).product([-1, 0, 1]).map(&:flatten) - [[0, 0, 0]]
DIRS4D = [-1, 0, 1].product([-1, 0, 1]).product([-1, 0, 1]).product([-1, 0, 1]).map(&:flatten) - [[0, 0, 0, 0]]
HEXDIRS = [
  [1, 0], [1, -1], [0, -1],
  [-1, 0], [-1, 1], [0, 1]
]

module Advent
  def self.input(format = :to_s)
    work_dir = Pathname.new(caller_locations(1..1).first.path).dirname
    infile = work_dir / "input"

    if !File.exist?(infile)
      puts "No input file #{infile}"
      exit
    end
    out = File.readlines(infile).map(&:chomp).map(&format)
    return out[0] if out.size == 1
    out
  end

  def self.rbsearch(goal, inexact: :min)
    cur = 1
    val = nil
    loop do
      val = yield cur
      break if val > goal
      cur *= 10
    end
    max = cur
    min = max / 10
    loop do
      return cur if val == goal
      return [min, max].send(inexact) if min + 1 == max

      cur = (min + max) / 2
      val = yield cur
      min = cur if val < goal
      max = cur if val > goal
    end
  end
end
