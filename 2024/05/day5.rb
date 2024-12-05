# frozen_string_literal: true

require_relative "../util"
require 'pry'
require 'pry-nav'

class Day5
  def initialize(env)
    prefix = env == "test" ? "example" : "actual"

    @rules = File.read("./files/05/#{prefix}_rules.txt").split("\n").each_with_object({}) do |numbers, tracker|
      num_1, num_2 = numbers.split("|")
      tracker[num_1] ||= []
      tracker[num_1] << num_2
    end

    @updates = File.read("./files/05/#{prefix}_page_updates.txt").split("\n").map { |l| l.split(",")}
  end

  def part_1
    @updates.filter_map { |u| middle(u) if valid?(u) }.sum
  end

  def part_2
    @updates.filter_map { |u| middle(correct(u)) unless valid?(u) }.sum
  end

  private

  def middle(update)
    update[update.length / 2].to_i if valid?(update)
  end

  def valid?(update)
    @rules.all? do |num, must_precede|
      num_index = update.index(num)

      next true unless num_index

      must_precede.all? do |n|
        n_index = update.index(n)

        next true unless n_index

        n_index > num_index
      end
    end
  end

  def correct(update)
    until valid?(update)
      @rules.each do |num, must_precede|
        num_index = update.index(num)

        next unless num_index

        min_index_of_must_precede = must_precede.filter_map { |must| update.index(must) }.min

        next unless min_index_of_must_precede
        next if num_index < min_index_of_must_precede

        update[min_index_of_must_precede].tap do |temp|
          update[min_index_of_must_precede] = num
          update[num_index] = temp
        end
      end
    end

    update
  end
end
