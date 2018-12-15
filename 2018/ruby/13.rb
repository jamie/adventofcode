require 'advent'
input = Advent.input(2018, 13)

# input = <<ENDL.split("\n")
# /->-\\        
# |   |  /----\\
# | /-+--+-\\  |
# | | |  | v  |
# \\-+-/  \\-+--/
#   \\------/   
# ENDL

carts = []

map = input.map.with_index{|row, y|
  row.split(//).map.with_index{|cell, x|
    case cell
    when 'v', '^'
      carts << [x, y, cell, 0]
      '|'
    when '<', '>'
      carts << [x, y, cell, 0]
      '-'
    else
      cell
    end
  }
}

def debug(map, carts)
  map.each.with_index{|row, y|
    row.each.with_index{|cell, x|
      occupied = carts.select{|cart| cart[0] == x && cart[1] == y}
      if occupied.size > 1
        print "\e[31mX\e[0m"
      elsif occupied.size == 1
        print "\e[32m#{occupied.first[2]}\e[0m"
      else
        print cell
      end
    }
    puts
  }
end

tick = 0

loop do
  tick += 1
  # debug(map, carts) if tick > 148

  carts.sort.each do |cart|
    x, y, dir, turn = cart

    # Move
    case dir
    when 'v'
      y += 1
    when '^'
      y -= 1
    when '<'
      x -= 1
    when '>'
      x += 1
    end
    cart[0] = x
    cart[1] = y

    # Crash?
    if carts.map{|i,j,_,_| [i,j]}.uniq.size < carts.size
      puts [x,y].join(',') if carts.size == 17 # Part 1
      carts.delete_if{|i,j,_,_| i == x && j == y}
    end

    # Turn corners
    case [dir, map[y][x]]
    when ['^', '/']
      dir = '>'
    when ['<', '/']
      dir = 'v'
    when ['v', '/']
      dir = '<'
    when ['>', '/']
      dir = '^'

    when ['^', '\\']
      dir = '<'
    when ['<', '\\']
      dir = '^'
    when ['v', '\\']
      dir = '>'
    when ['>', '\\']
      dir = 'v'
    end
    cart[2] = dir

    # Turn intersections
    if map[y][x] == '+'
      case [dir, turn%3]
      when ['^', 0]
        dir = '<'
      when ['<', 0]
        dir = 'v'
      when ['v', 0]
        dir = '>'
      when ['>', 0]
        dir = '^'
      when ['^', 2]
        dir = '>'
      when ['>', 2]
        dir = 'v'
      when ['v', 2]
        dir = '<'
      when ['<', 2]
        dir = '^'
      end
      turn += 1
    end
    cart[2] = dir
    cart[3] = turn
  end
  break if carts.size == 1
end

puts carts[0][0..1].join(',')

