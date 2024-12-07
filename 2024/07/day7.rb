# frozen_string_literal: true

require_relative "../util"

class Day7
  def initialize(env)
    @inputs = Util.load_inputs(env, "07").split("\n")
    @lines = @inputs.map do |i|
      expected_result, numbers = i.split(": ")
      [expected_result.to_i, numbers.split(" ").map(&:to_i)]
    end
  end

  def part_1
    @lines.select { |data| valid?(*data) }.map(&:first).sum
  end

  def part_2
    @lines.select { |data| valid?(*data, true) }.map(&:first).sum
  end

  private

  def valid?(expected_result, numbers, concat = false)
    results = []

    numbers.each_with_index do |num, i|
      results << num and next if i == 0

      results.map! { |r| [r + num, r * num, ([r, num].join.to_i if concat)].compact }.flatten!
    end

    results.include?(expected_result)
  end
end
