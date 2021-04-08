defmodule Advent do
  @moduledoc """
  Documentation for `Aoc`.
  """

  def read_lines(file) do
    {:ok, input} = File.read(file)
    input
    |> String.split("\n", trim: true)
  end

  def read_ints(file) do
    read_lines(file)
    |> Enum.map(&String.to_integer/1)
  end
end
