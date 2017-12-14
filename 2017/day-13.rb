input = File.readlines('input/13')

class Scanner
  attr_reader :pos, :range
  def initialize(range)
    @range = range
    reset
  end

  def step
    @pos += @dir
    @dir = 1 if @pos == 0
    @dir = -1 if @pos == @range-1
  end

  def reset
    @pos = 0
    @dir = 1
  end
end
class StubScanner
  def step
  end

  def reset
  end

  def pos
    1
  end
end

scanners = []
input.each do |line|
  line =~ /(\d+): (\d+)/
  scanners[$1.to_i] = Scanner.new($2.to_i)
end
100.times do |i|
  scanners[i] ||= StubScanner.new
end

def check_severity(delay, scanners, fail_fast=false)
  severity = 0
  depth = -1
  while depth < 100 do
    depth += 1
    if scanners[depth] && scanners[depth].pos == 0
      severity += depth * scanners[depth].range
      return 1 if fail_fast
    end
    scanners.compact.each(&:step)
  end
  severity
end

# Part 1
puts check_severity(0, scanners)
# Part 2
delay = 0
scanners.each(&:reset)
loop do
  sev = check_severity(delay, scanners.map(&:dup), true)
  break if sev.zero?

  delay += 2
  scanners.each(&:step)
  scanners.each(&:step)
end
puts delay
