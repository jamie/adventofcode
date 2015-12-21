mob = {
  hp: 104,
  atk: 8,
  def: 1,
}

player = {
  hp: 100,
  atk: 0,
  def: 0,
}

weap = [
  [:dagger,  8, 4, 0],
  [:short , 10, 5, 0],
  [:hammer, 25, 6, 0],
  [:long  , 40, 7, 0],
  [:axe   , 74, 8, 0],
]

arm = [
  [nil     ,  0, 0, 0],
  [:leather, 13, 0, 1],
  [:chain  , 31, 0, 2],
  [:splint , 53, 0, 3],
  [:banded , 75, 0, 4],
  [:plate  ,102, 0, 5],
]

ring = [
  [nil   ,  0, 0, 0],
  [nil   ,  0, 0, 0],
  [:atk1 , 25, 1, 0],
  [:atk2 , 50, 2, 0],
  [:atk3 ,100, 3, 0],
  [:def1 , 20, 0, 1],
  [:def2 , 40, 0, 2],
  [:def3 , 80, 0, 3],
]

puts 78 # Worked out in head, exact match stats cheapest
