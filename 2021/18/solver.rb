require "advent"
input = Advent.input.map { eval _1 }

_input = <<~STR.split("\n").map { eval _1 }
  [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
  [[[5,[2,8]],4],[5,[[9,9],0]]]
  [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
  [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
  [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
  [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
  [[[[5,4],[7,7]],8],[[8,3],8]]
  [[9,3],[[9,9],[6,[4,9]]]]
  [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
  [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
STR

# Part 1

def reduce(snail)
  snail = eval(snail.to_s) # Deep clone, since we mutate
  loop do
    explodes = false
    splits = false

    snail, explodes = explode(snail)
    snail, splits = split(snail) unless explodes
    break snail unless explodes || splits
  end
end

def explode(snail, depth = 4)
  left, right = snail
  leftcarry, rightcarry = 0, 0
  explodes = false

  if depth == 1
    if left.is_a?(Array)
      explodes = true
      leftcarry, rightcarry = left
      left = 0
      if right.is_a?(Integer)
        right += rightcarry
      else
        bubble_carry(right, rightcarry, 0)
      end
      rightcarry = 0
    elsif right.is_a?(Array)
      explodes = true
      leftcarry, rightcarry = right
      right = 0
      if left.is_a?(Integer)
        left += leftcarry
      else
        bubble_carry(left, 0, leftcarry)
      end
      leftcarry = 0
    end
  end

  if left.is_a?(Array)
    leftcarry, left, rightcarry, explodes = explode(left, depth - 1)
    if right.is_a?(Integer)
      right += rightcarry
    else
      bubble_carry(right, rightcarry, 0)
    end
    rightcarry = 0
  end
  if right.is_a?(Array) && !explodes
    leftcarry, right, rightcarry, explodes = explode(right, depth - 1)
    if left.is_a?(Integer)
      left += leftcarry
    else
      bubble_carry(left, 0, leftcarry)
    end
    leftcarry = 0
  end

  if depth == 4
    [[left, right], explodes]
  else
    [leftcarry, [left, right], rightcarry, explodes]
  end
end

def bubble_carry(subtree, add_to_left, add_to_right)
  left, right = subtree
  if add_to_left > 0
    if left.is_a?(Integer)
      subtree[0] = left + add_to_left
    else
      bubble_carry(left, add_to_left, add_to_right)
    end
  end
  if add_to_right > 0
    if right.is_a?(Integer)
      subtree[1] = right + add_to_right
    else
      bubble_carry(right, add_to_left, add_to_right)
    end
  end
end

def split(snail)
  left, right = snail
  splits = false
  if left.is_a?(Integer) && left >= 10
    a = left / 2
    b = left - a
    left = [a, b]
    splits = true
  elsif Array(left).flatten.any? { _1 >= 10 }
    left, splits = split(left)
  elsif right.is_a?(Integer) && right >= 10
    a = right / 2
    b = right - a
    right = [a, b]
    splits = true
  elsif Array(right).flatten.any? { _1 >= 10 }
    right, splits = split(right)
  end

  [[left, right], splits]
end

def magnitude(snail)
  if snail.is_a?(Integer)
    snail
  else
    left, right = snail
    3 * magnitude(left) + 2 * magnitude(right)
  end
end

puts magnitude(input.reduce { |first, second|
  reduce([first, second])
})

# Part 2

max = 0
input.each.with_index do |first, i|
  input.each.with_index do |second, j|
    next if i == j
    sum = reduce([first, second])
    val = magnitude(sum)
    max = [max, val].max
  end
end

puts max
