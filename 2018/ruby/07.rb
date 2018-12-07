require 'advent'
input = Advent.input(2018, 7)

dag = {}
input.each do |line|
  first, second = line.match(/Step (.) must be finished before step (.) can begin/).captures
  
  dag[first] ||= []
  dag[second] ||= []
  dag[second] << first
  dag[second].sort!
end

# Part 1

order = []

while order.size < dag.keys.size
  order << (dag.select{|k,v| v & order == v}.keys - order).sort.first
end

puts order.join

# Part 2

time = 0
work = [[], [], [], [], []]
done = []

while done.size < dag.keys.size
  workable = dag.select{|k,v|
    !done.include?(k) &&
    !work.map(&:first).include?(k) &&
    (v - done).empty?
  }

  work.each do |worker|
    if worker.empty? && workable.any?
      key = workable.keys.sort.first
      workable.delete(key)
      worker << key
      worker << worker[0].bytes[0] - 4 # Ascii A is 65, converts to 61
    end
  end

  time += 1

  work.each do |worker|
    next if worker.empty?

    worker[1] -= 1
    if worker[1] == 0
      done << worker[0]
      worker.clear
    end
  end
end

puts time