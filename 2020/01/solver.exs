numbers = Advent.read_ints("2020/01/input")

# numbers = [
#   1721,
#   979,
#   366,
#   299,
#   675,
#   1456
# ]

# Part 1
for x <- numbers,
    y <- numbers,
    x <= y,
    x + y == 2020,
    do: IO.puts(x * y)

# Part 2
for x <- numbers,
    y <- numbers,
    z <- numbers,
    x <= y,
    y <= z,
    x + y + z == 2020,
    do: IO.puts(x * y * z)
