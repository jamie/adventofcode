require "advent"
input = Advent.input

deck1 = input[1..25].map(&:to_i)
deck2 = input[28..52].map(&:to_i)

def score(deck)
  deck.reverse.zip(1..deck.size).map{|a,b| a*b}.sum
end

loop do
  c1, c2 = deck1.shift, deck2.shift

  if c1 > c2
    deck1 << c1 << c2
  else
    deck2 << c2 << c1
  end

  break if deck1.empty? || deck2.empty?
end

puts score(deck1)

# Part 2

deck1 = input[1..25].map(&:to_i)
deck2 = input[28..52].map(&:to_i)

def rcombat(d1, d2, depth=0)
  # p [depth, d1, d2]
  history = []
  loop do
    signature = [d1.join(','), d2.join(',')].join('-')
    if history.include?(signature)
      return [1, d1]
    end
    history << signature

    c1, c2 = d1.shift, d2.shift

    winner = nil
    if d1.size >= c1 && d2.size >= c2
      winner, _deck = rcombat(d1.dup[0...c1], d2.dup[0...c2], depth+1)
    end
    if winner ? winner == 1 : c1 > c2
      d1 << c1 << c2
    else
      d2 << c2 << c1
    end

    return [2, d2] if d1.empty?
    return [1, d1] if d2.empty?
  end
end

_, winner = rcombat(deck1, deck2)
puts score(winner)
