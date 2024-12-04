# frozen_string_literal: true

require_relative "../util"
require 'pry'
require 'pry-nav'

class Day4
  def initialize(env)
    @grid = {}

    Util.load_inputs(env, "04").split("\n").each_with_index do |line, i|
      @grid[i] = line.chars
    end
  end

  def part_1
    count = 0

    @grid.each do |row_num, line|
      x_indices = find_x_indices(line)

      next if x_indices.empty?

      x_indices.each do |x_index|
        count += 1 if match_down?(row_num, x_index)
        count += 1 if match_up?(row_num, x_index)
        count += 1 if match_right?(line, x_index)
        count += 1 if match_left?(line, x_index)
        count += 1 if match_up_right?(line, row_num, x_index)
        count += 1 if match_up_left?(line, row_num, x_index)
        count += 1 if match_down_right?(line, row_num, x_index)
        count += 1 if match_down_left?(line, row_num, x_index)
      end
    end

    count
  end

  def part_2
    count = 0

    @grid.each do |row_num, line|
      a_indices = find_a_indices(line)

      next if a_indices.empty?

      a_indices.each do |a_index|
        mas_up_right_down_left = match_up_right2?(line, row_num, a_index, "M") && match_down_left2?(line, row_num, a_index, "S")
        sam_up_right_down_left = match_up_right2?(line, row_num, a_index, "S") && match_down_left2?(line, row_num, a_index, "M")
        sam_up_left_down_right = match_up_left2?(line, row_num, a_index, "S") && match_down_right2?(line, row_num, a_index, "M")
        mas_up_left_down_right = match_up_left2?(line, row_num, a_index, "M") && match_down_right2?(line, row_num, a_index, "S")

        count += 1 if (sam_up_right_down_left  || mas_up_right_down_left) && (sam_up_left_down_right || mas_up_left_down_right)
      end
    end

    count
  end

  private

  def find_x_indices(arr)
    arr.each_index.select { |i| arr[i] == "X" }
  end

  def find_a_indices(arr)
    arr.each_index.select { |i| arr[i] == "A" }
  end

  def match_down?(row, x_index)
    return false if row > @grid.keys.size - 4
    return false unless @grid[row + 1][x_index] == "M"
    return false unless @grid[row + 2][x_index] == "A"

    @grid[row + 3][x_index] == "S"
  end

  def match_up?(row, x_index)
    return false if row < 3
    return false unless @grid[row - 1][x_index] == "M"
    return false unless @grid[row - 2][x_index] == "A"

    @grid[row - 3][x_index] == "S"
  end

  def match_right?(line, x_index)
    return false if x_index > line.length - 4
    return false unless line[x_index + 1] == "M"
    return false unless line[x_index + 2] == "A"

    line[x_index + 3] == "S"
  end

  def match_left?(line, x_index)
    return false if x_index < 3
    return false unless line[x_index - 1] == "M"
    return false unless line[x_index - 2] == "A"

    line[x_index - 3] == "S"
  end

  def match_up_right?(line, row, x_index)
    return false if row < 3
    return false if x_index > line.length - 4

    return false unless @grid[row - 1][x_index + 1] == "M"
    return false unless @grid[row - 2][x_index + 2] == "A"

    @grid[row - 3][x_index + 3] == "S"
  end

  def match_up_left?(line, row, x_index)
    return false if row < 3
    return false if x_index < 3

    return false unless @grid[row - 1][x_index - 1] == "M"
    return false unless @grid[row - 2][x_index - 2] == "A"

    @grid[row - 3][x_index - 3] == "S"
  end

  def match_down_right?(line, row, x_index)
    return false if row > @grid.keys.size - 4
    return false if x_index > line.length - 4

    return false unless @grid[row + 1][x_index + 1] == "M"
    return false unless @grid[row + 2][x_index + 2] == "A"

    @grid[row + 3][x_index + 3] == "S"
  end

  def match_down_left?(line, row, x_index)
    return false if row > @grid.keys.size - 4
    return false if x_index < 3

    return false unless @grid[row + 1][x_index - 1] == "M"
    return false unless @grid[row + 2][x_index - 2] == "A"

    @grid[row + 3][x_index - 3] == "S"
  end

  def match_up_right2?(line, row, x_index, value)
    return false if row < 1
    return false if x_index > line.length - 1

    @grid[row - 1][x_index + 1] == value
  end

  def match_down_left2?(line, row, x_index, value)
    return false if row >= @grid.keys.size - 1
    return false if x_index < 1

    @grid[row + 1][x_index - 1] == value
  end

  def match_up_left2?(line, row, x_index, value)
    return false if row < 1
    return false if x_index < 1

    @grid[row - 1][x_index - 1] == value
  end

  def match_down_right2?(line, row, x_index, value)
    return false if row >= @grid.keys.size - 1
    return false if x_index > line.length - 1

    @grid[row + 1][x_index + 1] == value
  end
end
