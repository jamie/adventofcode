require "advent"
input = Advent.input.sort

# Analysis
sleeps = {}
guard = nil
sleep_start = nil

input.each do |line|
  time = Time.parse(line.match(/\[(.*)\]/).captures[0])
  case line
  when /(\d+) begins shift/
    if guard && sleep_start
      # Slept til end of shift
      (sleep_start.min...60).each do |min|
        sleeps[guard][min] += 1
      end
    end

    guard = Regexp.last_match(1)
    sleeps[guard] ||= Hash.new { 0 }
  when /falls asleep/
    sleep_start = time
  when /wakes up/
    if !sleep_start
      # was asleep before midnight
      sleep_start = Time.mktime(1518) # 0 minutes
    end

    (sleep_start.min...time.min).each do |min|
      sleeps[guard][min] += 1
    end
    sleep_start = nil
  end
end

# Part 1
sleepy_guard, sleep = sleeps.sort_by { |guard, sleep| sleep.values.sum }.last
sleepy_minute = sleep.sort_by { |k, v| v }.last[0]
puts sleepy_guard.to_i * sleepy_minute

# Part 2
sleepy_max = sleeps.map { |_, sleep| sleep.values.max }.compact.max
sleepy_entry = sleeps.detect { |_, sleep| sleep.values.include?(sleepy_max) }
sleepy_guard = sleepy_entry[0]
sleepy_minute = sleepy_entry[1].to_a.sort_by { |k, v| v }.last[0]
puts sleepy_guard.to_i * sleepy_minute
