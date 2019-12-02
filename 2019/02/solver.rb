require "advent"
input = Advent.input(2019, 2)

class Intcode
  attr_reader :ip, :memory

  def initialize(input)
    @memory_base = input.split(",").map(&:to_i)
  end

  def reset(noun, verb)
    @memory = @memory_base.dup
    memory[1] = noun
    memory[2] = verb
  end

  def execute(noun, verb)
    reset(noun, verb)

    @ip = 0
    loop do
      case memory[ip]
      when 1
        add
      when 2
        mul
      else
        break
      end
    end
    memory[0]
  end

  private

  def args(*kind)
    kind.map.with_index do |k, i|
      case k
      when :p # pointer
        memory[ip + i + 1]
      else
        fail "Unknown argument kind: #{k}"
      end
    end
  end

  def add
    p1, p2, p3 = args(:p, :p, :p)
    memory[p3] = memory[p1] + memory[p2]
    @ip += 4
  end

  def mul
    p1, p2, p3 = args(:p, :p, :p)
    memory[p3] = memory[p1] * memory[p2]
    @ip += 4
  end
end

intcode = Intcode.new(input)
puts intcode.execute(12, 2)

(0..99).each do |noun|
  (0..99).each do |verb|
    value = intcode.execute(noun, verb)
    if value == 19690720
      puts noun * 100 + verb
      exit
    end
  end
end
