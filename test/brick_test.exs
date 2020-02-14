defmodule BrickTest do
  use ExUnit.Case
  import Tetris.Brick
  import Tetris.Points

  test "Creates a new brick" do
    assert new_brick().name == :i
  end

  test "Creates a new random brick" do
    actual = new_random()

    assert actual.name in [:i, :z, :l, :t, :o]
    assert actual.rotation in [0, 90, 180, 270]
    assert actual.reflection in [true, false]
  end

  test "should manipulate brick" do
    actual =
      new_brick()
      |> left
      |> right
      |> right
      |> down
      |> spin_90
      |> spin_90

    assert actual.location == {41, 1}
    assert actual.rotation == 180
  end

  test "should return points for i shape" do
    points = new_brick(name: :i) |> shape()
    assert {2, 1} in points
  end

  test "should return points for o shape" do
    points = new_brick(name: :o) |> shape()
    assert {3, 3} in points
  end

  test "should return points for t shape" do
    points = new_brick(name: :t) |> shape()
    assert {3, 2} in points
  end

  test "should return points for z shape" do
    points = new_brick(name: :z) |> shape()
    assert {3, 4} in points
  end

  test "should flip rotate flip and mirror" do
    [{1, 1}]
    |> mirror()
    |> assert_point({4, 1})
    |> flip()
    |> assert_point({4, 4})
    |> rotate_90()
    |> assert_point({1, 4})
    |> rotate_90()
    |> assert_point({1, 1})
  end

  def assert_point([actual], expected) do
    assert actual == expected
    [actual]
  end

  def new_brick(attributes \\ []), do: Tetris.Brick.new(attributes)
end
