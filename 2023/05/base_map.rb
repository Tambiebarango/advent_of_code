require 'pry'
require 'pry-nav'

class BaseMap
  def initialize(source_file)
    @almanac = File.read(source_file).split("\n")
    @map = generate_map
  end

  def lookup(source_number)
    source_start, sub_almanac = find_map_for(source_number)

    return source_number unless source_start && sub_almanac

    sub_almanac[:destination_start] + (source_number - source_start)
  end

  def find_min_from_range(source_number, length)
    binding.pry
    mins = []
    mins << lookup(source_number) if length.zero?

    until length == 0
      min_within_range = lookup(source_number)
      source_start, sub_almanac = find_map_for(source_number)
      remain_range = source_start + sub_almanac[:length] - source_number

      length =
        if remain_range.positive?
          0
        else
          source_number + length - (source_start + sub_almanac[:length])
       end

      mins << min_within_range
      source_number = source_start + sub_almanac[:length]
    end

    mins
  end

  def reverse_lookup(destination_number)
    source_start, sub_almanac = find_reverse_map_for(destination_number)

    return destination_number unless source_start && sub_almanac

    source_start + (destination_number - sub_almanac[:destination_start])
  end

  attr_reader :almanac, :map

  private
  def generate_map
    almanac.each_with_object({}) do |line, map|
      destination_start, source_start, length = line.split(' ').map(&:to_i)
      map[source_start] = { destination_start: destination_start, length: length }
    end
  end

  def find_map_for(source_number)
    map.find do |source_start, info|
      source_start <= source_number && source_number <= source_start + info[:length] - 1
    end
  end

  def find_reverse_map_for(source_number)
    map.find do |source_start, info|
      info[:destination_start] <= source_number && source_number <= info[:destination_start] + info[:length] - 1
    end
  end
end
