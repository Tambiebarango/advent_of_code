# frozen_string_literal: true

require_relative "../util"
require "pry"
require "pry-nav"

class Day9
  def initialize(env)
    @inputs = Util.load_inputs(env, "09")
    @disk_map = []
    @inputs.chars.each_with_index do |num, i|
      @disk_map += ([i/2] * num.to_i) if i.even?
      @disk_map += ([".#{i}"] * num.to_i) if i.odd?
    end
    @reverse_map = @disk_map.each_with_index.reverse_each.select { |num, i| num.is_a? Integer }
  end

  def part_1
    sum = 0

    @disk_map.each_with_index do |char, index|
      if !char.is_a? Integer
        target_char, target_index = @reverse_map.shift

        break if target_index < index

        @disk_map[index] = target_char
        @disk_map[target_index] = char

        sum += (target_char * index)
      else
        sum += (char * index)
      end
    end

    sum
  end

  def part_2
    sum = 0
    file, free_space = @disk_map.partition { |char| char.is_a? Integer }
    free_space_tally = free_space.tally
    reverse_tally = file.reverse.tally

    reverse_tally.each do |char, count|
      max_index = @disk_map.index(char) # free space can't exceed this index

      target_index = @disk_map[..max_index - 1].index { |main_char| !main_char.is_a?(Integer) && free_space_tally[main_char] >= count }

      next if target_index.nil?

      target_char = @disk_map[target_index]
      target_count = free_space_tally[target_char]

      @disk_map[target_index..target_index + count - 1] = [char] * count
      @disk_map[max_index..max_index + count - 1] = [target_char] * count

      free_space_tally[target_char] = target_count - count
    end

    puts "Calculating sum now"

    @disk_map.each_with_index do |char, index|
      next unless char.is_a?(Integer)

      sum += (char * index)
    end

    sum
  end
end

pp Day9.new("actual").part_2
