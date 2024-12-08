# frozen_string_literal: true

require_relative "../util"
require "pry"
require "pry-nav"

class Day8
  def initialize(env)
    @inputs = Util.load_inputs(env, "08").split("\n")
    @grid = {}

    @inputs.each_with_index do |line, row|
      line.chars.each_with_index do |char, column|
        @grid[[row, column]] = char
      end
    end
  end

  def part_1
    new_grid = @grid.dup
    antennas = @grid.values.uniq.select { |v| v != "." }

    antennas.each do |antenna|
      coordinates = @grid.select { |_, v| v == antenna }.keys
      coordinates.combination(2).each do |antenna1, antenna2|
        distance = distance_tuple(antenna1, antenna2)

        antinode_location_1 = antenna1.zip(distance).map { |tuple| tuple.inject(:-) }
        antinode_location_2 = antenna2.zip(distance).map(&:sum)

        new_grid[antinode_location_1] = "#" if @grid.key?(antinode_location_1)
        new_grid[antinode_location_2] = "#" if @grid.key?(antinode_location_2)
      end
    end

    new_grid.count { |_, v| v == "#" }
  end

  def part_2_old
    new_grid = @grid.dup
    antennas = @grid.values.uniq.select { |v| v != "." }

    antennas.each do |antenna|
      coordinates = @grid.select { |_, v| v == antenna }.keys

      coordinates.combination(2).each do |antenna1, antenna2|
        distance = distance_tuple(antenna1, antenna2)

        new_grid[antenna1] = "#"
        new_grid[antenna2] = "#"

        antinode_location_1 = antenna1.zip(distance).map { |tuple| tuple.inject(:-) }
        antinode_location_2 = antenna2.zip(distance).map(&:sum)

        if @grid.key?(antinode_location_1)
          new_grid[antinode_location_1] = "#"

          out_of_grid = false

          loop do
            antinode_location_1 = antinode_location_1.zip(distance).map { |tuple| tuple.inject(:-) }
            out_of_grid = !@grid.key?(antinode_location_1)

            break if out_of_grid

            new_grid[antinode_location_1] = "#"
          end
        end

        if @grid.key?(antinode_location_2)
          new_grid[antinode_location_2] = "#"

          out_of_grid = false

          loop do
            antinode_location_2 = antinode_location_2.zip(distance).map(&:sum)
            out_of_grid = !@grid.key?(antinode_location_2)

            break if out_of_grid

            new_grid[antinode_location_2] = "#"
          end
        end
      end
    end

    pp new_grid.count { |_, v| v == "#" }
  end

  private

  def distance_tuple(start_coord, destination_coord)
    start_coord.zip(destination_coord).map do |num_1, num_2|
      num_2 - num_1
    end
  end
end

# 4, 4
Day8.new("actual").part_2_old
