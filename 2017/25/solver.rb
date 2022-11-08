# Manual input, parsing would be annoying
input = {
  "A" => [[1, 1, "B"], [0, -1, "F"]],
  "B" => [[0, 1, "C"], [0, 1, "D"]],
  "C" => [[1, -1, "D"], [1, 1, "E"]],
  "D" => [[0, -1, "E"], [0, -1, "D"]],
  "E" => [[0, 1, "A"], [1, 1, "C"]],
  "F" => [[1, -1, "A"], [1, 1, "A"]]
}
state = "A"
target = 12794428

tape = Hash.new { 0 }
ptr = 0
target.times do
  val = tape[ptr]
  op = input[state][val]
  tape[ptr] = op[0]
  ptr += op[1]
  state = op[2]
end

puts tape.values.count(1)
