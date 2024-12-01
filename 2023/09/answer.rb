require 'pry'
require 'pry-nav'

lines = File.read('09/input.txt').split("\n").map { |nums| nums.split(' ').map(&:to_i) }

def get_interval(line)
  (1..line.size - 1).map do |i|
    current_value = line[i]
    previous_value = line[i - 1]

    current_value - previous_value
  end
end

def get_all_intervals_until_zero(line)
  differences = get_interval(line)
  line_map = [line, differences]

  until differences.all?(&:zero?)
    differences = get_interval(differences)
    line_map << differences
  end

  line_map
end

def insert_prediction(line, pos)
  line_map = get_all_intervals_until_zero(line)
  tracker = []
  enum_method = pos.zero? ? :first : :last
  math_method = pos.zero? ? :- : :+

  line_map.reverse.each_with_index do |line, i|
    diff = line.all?(&:zero?) ? 0 : tracker[i - 1].send(enum_method)
    to_insert = [*line]
    to_insert.insert(pos, line.send(enum_method).send(math_method, diff))
    tracker << to_insert
  end

  tracker.last
end

# Part 1
new_lines_with_last_digit = lines.map { |l| insert_prediction(l, -1) }

pp new_lines_with_last_digit.map(&:last).sum

# Part 2
new_lines_with_first_digit = lines.map { |l| insert_prediction(l, 0) }

pp new_lines_with_first_digit.map(&:first).sum
