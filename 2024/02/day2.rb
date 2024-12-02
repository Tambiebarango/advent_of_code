# frozen_string_literal: true

require_relative '../util'

class Day2
  def self.load_inputs(env)
    content = Util.load_inputs(env, "02")

    content.split("\n").map { |line| line.split(/\s+/).map(&:to_i) }
  end

  attr_reader :inputs

  def initialize(env)
    @inputs = Day2.load_inputs(env)
  end

  def part_1
    inputs.count { |arr| safe?(arr) }
  end

  def part_2
    inputs.count do |list|
      next true if safe?(list)

      kind_of_safe?(list)
    end
  end

  private

  def safe?(arr)
    all_increasing_or_decreasing?(difference(arr)) && valid_level_change?(difference(arr))
  end

  def kind_of_safe?(list)
    safe = false

    list.each_with_index do |element, i|
      if safe? list.dup.tap { |l| l.delete_at(i) }
        safe = true
        break
      end
    end

    safe
  end

  def valid_level_change?(diff)
    min, max = diff.reject(&:zero?).map(&:abs).minmax.sort

    min >= 1 && max <= 3
  end

  def all_increasing_or_decreasing?(diff)
    diff.all?(&:positive?) || diff.all?(&:negative?)
  end

  def difference(arr)
    arr.each_cons(2).map do |a, b|
      b - a
    end
  end
end
