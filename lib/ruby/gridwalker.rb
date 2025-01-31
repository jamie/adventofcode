class GridWalker
  attr_accessor :x, :y, :dir

  def initialize(x: 0, y: 0, dir: :n)
    @x = x
    @y = y
    @dir = dir
  end

  def pos
    [@x, @y]
  end

  TURNS = {
    n: [:w, :e],
    e: [:n, :s],
    s: [:e, :w],
    w: [:s, :n]
  }.freeze

  def left!
    @dir = TURNS[dir][0]
    self
  end

  def right!
    @dir = TURNS[dir][1]
    self
  end

  def forward!
    case dir
    when :n then @y -= 1
    when :s then @y += 1
    when :e then @x += 1
    when :w then @x -= 1
    end
    self
  end
end
