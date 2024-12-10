# frozen_string_literal: true

require_relative "../util"
require "pry"
require "pry-nav"

class Day10
  def initialize(env)
    @inputs = Util.load_inputs(env, "10").split("\n")
    @grid = {}

    @inputs.each_with_index do |line, row|
      line.chars.each_with_index do |char, column|
        @grid[[row, column]] = char.to_i.to_s == char ? char.to_i : char
      end
    end
  end

  def part_1
    grand_tracker = {}
    @grid.select { |_, v| v == 9 }.each do |(row, column), v|
      tracker = [[row, column]]
      # binding.pry if tracker == [[6, 6, 9]]

      loop do
        # pp "Before map Tracker is #{tracker} and v is #{v}"

        tracker.map! do |r, c|
          # binding.pry if r == 6 && c == 6
          # binding.pry if r == 12 and c == 6
          v = @grid[[r, c]]
          # binding.pry
          # move up
          up = [r - 1, c] if @grid[[r - 1, c]] == v - 1
          # move down
          down = [r + 1, c] if @grid[[r + 1, c]] == v - 1
          # move left
          left = [r, c - 1] if @grid[[r, c - 1]] == v - 1
          # move right
          right = [r, c + 1] if @grid[[r, c + 1]] == v - 1

          # binding.pry if up = [0, 3, 0]
          # binding.pry if [up, down, left, right].include? [1, 2]
          # pp "Results of #{r}, #{c}, #{v}..."
          # pp [up, down, left, right].compact
          [up, down, left, right].compact
        end

        # pp "After map, tracker is #{tracker}"
        tracker.flatten!(1)
        tracker.uniq!
        break if tracker.empty? || tracker.any? { |r, c| @grid[[r, c]] == 0 }
      end

      tracker.each do |coordinates|
        grand_tracker[coordinates] ||= 0
        grand_tracker[coordinates] += 1
      end
    end

    grand_tracker.values.sum
  end

  def part_2
    grand_tracker = {}
    @grid.select { |_, v| v == 9 }.each do |(row, column), v|
      tracker = [[row, column]]
      # binding.pry if tracker == [[6, 6, 9]]

      loop do
        # pp "Before map Tracker is #{tracker} and v is #{v}"

        tracker.map! do |r, c|
          # binding.pry if r == 6 && c == 6
          # binding.pry if r == 12 and c == 6
          v = @grid[[r, c]]
          # binding.pry
          # move up
          up = [r - 1, c] if @grid[[r - 1, c]] == v - 1
          # move down
          down = [r + 1, c] if @grid[[r + 1, c]] == v - 1
          # move left
          left = [r, c - 1] if @grid[[r, c - 1]] == v - 1
          # move right
          right = [r, c + 1] if @grid[[r, c + 1]] == v - 1

          # binding.pry if up = [0, 3, 0]
          # binding.pry if [up, down, left, right].include? [1, 2]
          # pp "Results of #{r}, #{c}, #{v}..."
          # pp [up, down, left, right].compact
          [up, down, left, right].compact
        end

        # pp "After map, tracker is #{tracker}"
        tracker.flatten!(1)
        # tracker.uniq!
        break if tracker.empty? || tracker.any? { |r, c| @grid[[r, c]] == 0 }
      end

      tracker.each do |coordinates|
        grand_tracker[coordinates] ||= 0
        grand_tracker[coordinates] += 1
      end
    end

    grand_tracker.values.sum
  end
end

# pp Day10.new("test").part_1
pp Day10.new("actual").part_1
pp Day10.new("actual").part_2
