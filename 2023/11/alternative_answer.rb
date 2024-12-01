require 'pry'
require 'pry-nav'

input = File.read('11/input.txt').split("\n")

def contains_pound?(row)
  row.include?('#')
end

def expand_rows(rows)
  rows.each_with_index.each_with_object({}) do |row_index, row_expansion_map|
    row, index = row_index

    row_expansion_map[index] = contains_pound?(row)
  end
end

def expand_columns(rows)
  size = rows.first.size

  (0..size - 1).each_with_object({}) do |i, column_expansion_map|
    column_expansion_map[i] = rows.any? { |r| r[i] == '#' }
  end
end

ROW_EXPANSION = expand_rows(input)
COLUMN_EXPANSION = expand_columns(input)
FACTOR = 999_999

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
  input.each_with_index.select.each_with_object({}) do |ewi, galaxy_map|
    line_arr, y_index = ewi
    line_arr.each_with_index do |char, x_index|
      next unless char.is_a?(Integer)

      galaxy_map["#{x_index},#{y_index}"] = char
    end
    galaxy_map
  end
end

def columns_with_no_galaxy
  COLUMN_EXPANSION.select { |_col, has_galaxy| has_galaxy == false }
end

def rows_with_no_galaxy
  ROW_EXPANSION.select { |_row, has_galaxy| has_galaxy == false }
end

def get_distance(coord_1, coord_2)
  x1, y1 = coord_1.split(',').map(&:to_i)
  x2, y2  =coord_2.split(',').map(&:to_i)
  number_of_expanded_columns = (columns_with_no_galaxy.keys & (([x1,x2].min)..([x1,x2].max)).to_a).size
  number_of_expanded_rows = (rows_with_no_galaxy.keys & (([y1,y2].min)..([y1,y2].max)).to_a).size

  (x2 - x1).abs + (y2 - y1).abs + (number_of_expanded_columns * FACTOR) + (number_of_expanded_rows * FACTOR)
end


new_rows = transform(input)
galaxy_map = map_galaxies(new_rows)

sum_of_distance = galaxy_map.values.combination(2).map do |v1, v2|
  coord_1 = galaxy_map.find { |_k, v| v == v1 }.first
  coord_2 = galaxy_map.find { |_k, v| v == v2 }.first

  get_distance(coord_1, coord_2)
end

pp sum_of_distance.sum
