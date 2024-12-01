require 'pry'
require 'pry-nav'

input = File.read('11/sample.txt').split("\n")

def contains_pound?(row)
  row.include?('#')
end

def expand_rows(rows)
  rows.each_with_object([]) do |row, new_rows|
    if contains_pound?(row)
      new_rows << row
    else
      1_000_000.times { new_rows << row }
    end
    new_rows
  end
end

def expand_columns(rows)
  size = rows.first.size
  new_rows = rows.dup.map { |r| r.split('').map { |char| [char] } }

  (0..size - 1).each do |i|
    next if rows.any? { |r| r[i] == '#' }

    new_rows.each do |row|
      row[i] = row[i] * 1_000_000
    end
  end

  new_rows.map(&:flatten).map(&:join)
end

def transform(input)
  start = 0

  input.map do |line|
    line.split('').map do |char|
      if char == '#'
        start += 1
        start
      else
        char
      end
    end
  end
end

def map_galaxies(input)
  input.each_with_index.each_with_object({}) do |ewi, galaxy_map|
    line_arr, y_index = ewi
    line_arr.each_with_index do |char, x_index|
      next unless char.is_a?(Integer)

      galaxy_map["#{x_index},#{y_index}"] = char
    end
    galaxy_map
  end
end

new_rows = expand_rows(input)
new_rows = expand_columns(new_rows)
new_rows = transform(new_rows)
galaxy_map = map_galaxies(new_rows)


sum_of_distance = galaxy_map.values.combination(2).map do |v1, v2|
  x1, y1 = galaxy_map.find { |_k, v| v == v1 }.first.split(',').map(&:to_i)
  x2, y2 = galaxy_map.find { |_k, v| v == v2 }.first.split(',').map(&:to_i)

  (x2 - x1).abs + (y2 - y1).abs
end

pp sum_of_distance.sum
