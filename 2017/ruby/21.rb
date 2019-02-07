require 'advent'
input = Advent.input(2017, 21)
require 'pp'

class Pattern
  def initialize(rule)
    pattern, output = rule.chomp.split(" => ")
    @output = output.split("/").map{|ss| ss.split(//) }

    base_pattern = pattern.split("/").map{|ss| ss.split(//) }
    @patterns = [
      base_pattern,
      rotate(1, base_pattern),
      rotate(2, base_pattern),
      rotate(3, base_pattern),
      flip(base_pattern),
      flip(rotate(1, base_pattern)),
      flip(rotate(2, base_pattern)),
      flip(rotate(3, base_pattern)),
    ]
  end

  def matches?(input)
    @patterns.include?(input)
  end

  def output
    @output
  end

private
  def flip(pattern)
    pattern.map(&:reverse)
  end

  def rotate(i, pattern)
    i.times do
      pattern = if pattern.size == 2
        [
          [ pattern[0][1], pattern[1][1] ],
          [ pattern[0][0], pattern[1][0] ],
        ]
      else
        [
          [ pattern[0][2], pattern[1][2], pattern[2][2] ],
          [ pattern[0][1], pattern[1][1], pattern[2][1] ],
          [ pattern[0][0], pattern[1][0], pattern[2][0] ],
        ]
      end
    end
    pattern
  end
end

class Grid
  def initialize(patterns)
    @grid = ".#.\n..#\n###"
    @patterns = patterns
  end

  def step
    blocks = []
    explode do |block|
      pattern = @patterns.detect{|pat| pat.matches? block }
      blocks << pattern.output
    end
    implode blocks
  end

  def count_ons
    @grid.split(//).count('#')
  end

private
  def explode
    size = (@grid.split("\n").size % 2 == 0) ? 2 : 3
    @grid.split("\n").each_slice(size) do |row_set|
      row_set.map{|row| row.split(//).each_slice(size).to_a }.transpose.each do |block|
        yield block
      end
    end
  end

  def implode(blocks)
    size = (@grid.split("\n").size % 2 == 0) ? 2 : 3
    size_blocks = @grid.split("\n").size / size
    @grid = blocks.each_slice(size_blocks).map do |blocks_for_rows|
      blocks_for_rows.transpose.map{|row| row.join() }.join("\n")
    end.join("\n")
  end
end

patterns = input.map{|rule| Pattern.new(rule)}

grid = Grid.new(patterns)
5.times { grid.step }
puts grid.count_ons

grid = Grid.new(patterns)
18.times { grid.step }
puts grid.count_ons
