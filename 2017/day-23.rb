input = File.readlines('input/23')

require './bytecode-interpreter'

class MulCountingProgram < Program
  attr_reader :mul_count

  def initialize(*)
    super
    @mul_count = 0
  end

  def mul(*)
    super
    @mul_count += 1
  end
end

prog = MulCountingProgram.new(input)
prog.run
puts prog.mul_count

# part 2: Manually convert assembly to ruby, and then hand-optimize

def run(a)
  mul = 0
  h = 0
  b = 99             # set b 99
  c = b              # set c b
  if a != 0          # jnz a 2
                     # jnz 1 5     ------\
    b *= 100         # mul b 100         |
    b += 100_000     # add b 100000      |
    c = b            # set c b           |
    c += 17_000      # add c 17000       |
  end
  loop do            #             <----<
    f = 1            # set f 1           |
    d = 2            # set d 2           |
    begin
      e = 2          # set e 2     <---\ |
      begin
                     # set g d     <-\ | |
        mul += 1             # mul g e       | | |
        g = d*e-b    # sub g b       | | |
        if g == 0    # jnz g 2  --\  | | |
          f = 0      # set f 0    |  | | |
        end
        e += 1       # add e 1  <-/  | | |
                     # set g e       | | |
        g = e-b      # sub g b       | | |
      end while g != 0 # jnz g -8  --/ | |
      d += 1         # add d 1         | |
                     # set g d         | |
      g = d-b        # sub g b         | |
    end while g != 0 # jnz g -13   ----/ |
    if f == 0        # jnz f 2           |
      h += 1         # add h 1           |
    end
                     # set g b           |
    g = b-c          # sub g c           |
    if g == 0        # jnz g 2           | -----\
      puts mul
      return h       # jnz 1 3           | -\   |
    end
    b += 17          # add b 17          |  | <-/
  end                # jnz 1 -23   ------/  v
end
puts run(0)
puts run(1)
