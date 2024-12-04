# frozen_string_literal: true

require_relative "../util"

class Day3
  def initialize(env)
    @inputs = Util.load_inputs(env, "03")
  end

  def part_1(str = @inputs)
    regex = /mul\((\d{1,3})\,(\d{1,3})\)/
    instructions = str.scan regex
    instructions.map { |num_1, num_2| num_1.to_i * num_2.to_i }.sum
  end

  def part_2(str = @inputs)
    valid_strings = ("do()" + str).split(/don't\(\)/).filter_map do |str|
      index_of_do = str.index(/do\(\)/)

      next unless index_of_do

      str[index_of_do + 4..]
    end

    part_1(valid_strings.join(''))
  end
end
