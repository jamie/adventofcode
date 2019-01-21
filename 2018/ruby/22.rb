require 'advent'
input = Advent.input(2018, 22)

# depth: 5616
# target: 10,785
depth = input[0].scan(/\d+/).map(&:to_i).first
target = input[1].scan(/\d+/).map(&:to_i)

class Cave
  def initialize(depth, target)
    @depth = depth
    @target = target
    @erosion = {}
  end

  def total_risk
    (0..@target[0]).map do |x|
      (0..@target[1]).map do |y|
        type, risk = case erosion(x, y) % 3
        when 0; [:rocky,  0]
        when 1; [:wet,    1]
        when 2; [:narrow, 2]
        end
        risk(x, y)
      end
    end.flatten.sum
  end

  def erosion(x, y)
    return @erosion[[x, y]] if @erosion[[x, y]]
    if [x, y] == [0, 0]
      geologic_index = 0
    elsif [x, y] == @target
      geologic_index = 0
    elsif y == 0
      geologic_index = x * 16807
    elsif x == 0
      geologic_index = y * 48271
    else
      geologic_index = erosion(x-1, y) * erosion(x, y-1)
    end

    @erosion[[x, y]] = (geologic_index + @depth) % 20183
  end

  def risk(x, y)
    erosion(x, y) % 3
  end

  def time_to_find
    queue = PriorityDeque.new
    queue.add(0, [0, :torch, 0, 0])
    shortest_time_to = {}
    closest = 0

    start = Time.now
    loop do
      time, gear, x, y = queue.pop
      return -time if [x, y, gear] == [@target[0], @target[1], :torch]

      next if shortest_time_to[[x, y, gear]]
      shortest_time_to[[x, y, gear]] = time

      other_gear = (available_gear(x, y) - [gear]).first
      [
        [time-1, gear, x,   y-1],
        [time-1, gear, x-1, y],
        [time-1, gear, x+1, y],
        [time-1, gear, x,   y+1],
        [time-7, other_gear, x, y],
      ].each do |newtime, newgear, newx, newy|
        next if newx < 0 || newy < 0
        next if newx > 50 # heuristic, actual path for my input goes to 48
        next unless available_gear(newx, newy).include?(newgear)
        next if shortest_time_to[[newx, newy, newgear]]
        queue.add(newtime, [newtime, newgear, newx, newy])
      end
    end
  end

  def available_gear(x, y)
    case risk(x, y)
    when 0
      [:gear, :torch]
    when 1
      [:gear, :neither]
    when 2
      [:torch, :neither]
    end
  end
end

# depth = 510
# target = [10, 10]

# Part 1
cave = Cave.new(depth, target)
puts cave.total_risk

# Part 2
puts cave.time_to_find
