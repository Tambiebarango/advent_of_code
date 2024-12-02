# frozen_string_literal: true

require_relative '../util'

class Day1
  def self.load_numbers(env)
    content = Util.load_inputs(env)

    list1 = []
    list2 = []

    content.split("\n").map do |line|
      num1, num2 = line.split(/\s+/)
      list1 << num1
      list2 << num2
    end

    [list1.map(&:to_i), list2.map(&:to_i)]
  end

  class Part2
    def self.run(env)
      similarity_score(*Day1.load_numbers(env))
    end

    def self.similarity_score(list1, list2)
      tracker = {}

      list1.map { |num| num * (tracker[num] || number_of_occurences(num, list2)) }.sum
    end

    def self.number_of_occurences(num, arr)
      arr.count(num)
    end
  end

  class Part1
    def self.run(env)
      total_distance(*Day1.load_numbers(env))
    end

    def self.total_distance(list1, list2)
      list1.sort
           .zip(list2.sort)
           .map { |arr| distance(*arr) }
           .sum
    end

    def self.distance(num1, num2)
      (num1 - num2).abs
    end
  end
end

