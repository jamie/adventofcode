require "advent"
input = Advent.input

# Part 1
cards = (0..10006).to_a

input.each do |command|
  case command
  when "deal into new stack"
    cards = cards.reverse
  when /cut (-?\d+)/
    n = $1.to_i
    n += cards.size if n < 0
    cards = cards[n..-1] + cards[0...n]
  when /deal with increment (\d+)/
    n = $1.to_i
    newcards = []
    cards.size.times do |i|
      newcards[(i * n) % cards.size] = cards[i]
    end
    cards = newcards
  else
    puts "I don't know how to #{command}"
    exit
  end
end

puts cards.index(2019)

# Part 2

exit # ugh reversing this is a mess, I'm giving up

input = <<IN.split("\n")
deal with increment 7
deal with increment 9
cut -2
IN

deck_size = 10 # 10007 # 119315717514047
iterations = 1 # 101741582076661
init_offset = 0 # 2939 # 2020

10.times do |init_offset|

offset = init_offset
iterations.times do |iter|
  # puts iter if iter % 1000 == 0
  input.reverse.each do |command|
    case command
    when "deal into new stack"
      offset = deck_size - (offset + 1)
    when /cut (-?\d+)/
      n = $1.to_i
      n += deck_size if n < 0
      offset += n
    when /deal with increment (\d+)/
      n = $1.to_i
      offset *= (deck_size % n)
    else
      puts "I don't know how to #{command}"
      exit
    end
    offset %= deck_size
  end
  puts offset
end

end

# Not 63752835085254
# Not 43942855235503
# Not 75372862282584
