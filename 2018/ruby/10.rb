require 'advent'
input = Advent.input(2018, 10)

# position=< 9,  1> velocity=< 0,  2>
# position=< 7,  0> velocity=<-1,  0>

stars = input.map{|line|
  line.match(/position=<(.*),(.*)> velocity=<(.*),(.*)/).captures.map(&:to_i)
}

def area(stars)
  x_min = stars.map{|x,y,dx,dy| x}.min
  x_max = stars.map{|x,y,dx,dy| x}.max
  y_min = stars.map{|x,y,dx,dy| y}.min
  y_max = stars.map{|x,y,dx,dy| y}.max
end

def render(stars)
  x_min = stars.map{|x,y,dx,dy| x}.min
  x_max = stars.map{|x,y,dx,dy| x}.max
  y_min = stars.map{|x,y,dx,dy| y}.min
  y_max = stars.map{|x,y,dx,dy| y}.max

  (y_min..y_max).each do |y|
    (x_min..x_max).each do |x|
      if stars.any?{|sx,sy,dx,dy| x == sx && y == sy}
        print '#'
      else
        print ' '
      end
    end
    puts
  end
  puts
end

i = 0
min_area = area(stars)
loop do
  # check
  new_area = area(stars)
  if new_area > min_area
    # unwind drift, gone too far
    stars.each do |star|
      star[0] -= star[2]
      star[1] -= star[3]
    end
    break
  else
    min_area = new_area
  end
  
  # drift
  stars.each do |star|
    star[0] += star[2]
    star[1] += star[3]
  end
  i += 1
end

# Part 1
render(stars) # Manually render for batch output
puts "XECXBPZB" 

# Part 2
puts i
