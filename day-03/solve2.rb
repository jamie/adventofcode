world = []

Actor = Struct.new(:x, :y)
santa = Actor.new(0,0)
robot = Actor.new(0,0)

def gift!(world, actor)
  world[actor.x+1000] ||= []
  world[actor.x+1000][actor.y+1000] ||= 0
  world[actor.x+1000][actor.y+1000] += 1
end

gift!(world, santa)

santas = [santa, robot]

File.read('input').split(//).each do |cmd|
  actor = santas.shift
  case cmd
  when '>'
    actor.x += 1
  when '<'
    actor.x -= 1
  when 'v'
    actor.y -= 1
  when '^'
    actor.y += 1
  end
  gift!(world, actor)
  santas << actor
end

puts world.flatten.compact.size
