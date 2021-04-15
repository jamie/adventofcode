defmodule Advent do
  @moduledoc """
  Documentation for `Aoc`.
  """

  def read_lines(file) do
    {:ok, input} = File.read(file)
    input
    |> String.split("\n")
  end

  def read_ints(file) do
    {:ok, input} = File.read(file)
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
