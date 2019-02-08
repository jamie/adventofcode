require 'advent'
input = Advent.input(2018, 18)

SIZE = input.size
yard = input.map{|line| line.split(//)}

def step(yard)
  new_yard = ([''] * SIZE).map{[]}
  SIZE.times do |y|
    SIZE.times do |x|
      ground = 0
      trees = 0
      lumber = 0
      (-1..1).each do |dy|
        next unless (0...SIZE).include?(y+dy)
        (-1..1).each do |dx|
          next unless (0...SIZE).include?(x+dx)
          next if [dx, dy] == [0, 0]
          case yard[y+dy][x+dx]
          when '.'; ground += 1
          when '|'; trees += 1
          when '#'; lumber += 1
          end
        end
      end

      case yard[y][x]
      when '.'
        new_yard[y][x] = (trees >= 3 ? '|' : '.')
      when '|'
        new_yard[y][x] = (lumber >= 3 ? '#' : '|')
      when '#'
        new_yard[y][x] = (trees >= 1 && lumber >= 1 ? '#' : '.')
      end
    end
  end
  new_yard
end

# Part 1
10.times { yard = step(yard) }
puts yard.flatten.count('|') * yard.flatten.count('#')

# Part 2, 1b iterations is 40 days. Instead look for cycles
old_score = 0
yards = [yard]
yard = input.map{|line| line.split(//)}
1_000_000_000.times {|n|
  yard = step(yard)
  # Dunno why it's finding a cycle around n=10... Ignore that one
  if n > 100 && yards.include?(yard)
    break
  end
  yards << yard
}
yards << yard

cycle_first = yards.index(yard)
cycle_last = yards.size-1
cycle_size = cycle_last - cycle_first

n = 1_000_000_000
n -= cycle_size while n > yards.size
yard1billion = yards[n]
puts yard1billion.flatten.count('|') * yard1billion.flatten.count('#')
