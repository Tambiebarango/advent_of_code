input = File.read('03/input.txt')

def no_digit_before?(start, number, line)
  start == 0 || line[start - 1].match?(/[^\d]/)
end

def no_digit_after?(start, number, line)
  number_end = start + number.length - 1
  number_end == line.length - 1 || line[number_end + 1].match?(/[^\d]/)
end

def symbol_right?(start, number, line)
  number_end = start + number.length - 1
  return false if number_end == line.length - 1

  line[number_end + 1].match?(/[^(A-Z)|(0-9)|\.]/i)
end

def symbol_left?(start, number, line)
  return false if start == 0

  line[start - 1].match?(/[^(A-Z)|(0-9)|\.]/i)
end

def symbol_up?(start, number, line, lines)
  current_line_index = lines.index(line)
  return false if current_line_index == 0

  number_end = start + number.length - 1
  line_above = lines[current_line_index - 1]
  line_above[start..number_end].match?(/[^(A-Z)|(0-9)|\.]/i)
end

def symbol_down?(start, number, line, lines)
  current_line_index = lines.index(line)
  return false if current_line_index == lines.length - 1

  number_end = start + number.length - 1
  line_below = lines[current_line_index + 1]
  line_below[start..number_end].match?(/[^(A-Z)|(0-9)|\.]/i)
end

def symbol_top_right?(start, number, line, lines)
  current_line_index = lines.index(line)
  return false if current_line_index == 0

  number_end = start + number.length - 1
  return false if number_end == line.length - 1

  line_above = lines[current_line_index - 1]
  line_above[number_end + 1].match?(/[^(A-Z)|(0-9)|\.]/i)
end

def symbol_top_left?(start, number, line, lines)
  current_line_index = lines.index(line)
  return false if current_line_index == 0

  return false if start == 0

  line_above = lines[current_line_index - 1]
  line_above[start - 1].match?(/[^(A-Z)|(0-9)|\.]/i)
end

def symbol_bottom_right?(start, number, line, lines)
  current_line_index = lines.index(line)
  return false if current_line_index == lines.length - 1

  number_end = start + number.length - 1
  return false if number_end == line.length - 1

  line_below = lines[current_line_index + 1]
  line_below[number_end + 1].match?(/[^(A-Z)|(0-9)|\.]/i)
end

def symbol_bottom_left?(start, number, line, lines)
  current_line_index = lines.index(line)
  return false if current_line_index == lines.length - 1

  return false if start == 0

  line_below = lines[current_line_index + 1]
  line_below[start - 1].match?(/[^(A-Z)|(0-9)|\.]/i)
end


lines = input.split("\n")
numbers_adjacent_to_symbols = []

lines.each do |line|
  numbers = line.scan(/\d+/).uniq
  numbers.each do |number|
    positions = line.to_enum(:scan, /#{number}/).map { Regexp.last_match.begin(0) }
    positions.each do |start|
      next unless no_digit_before?(start, number, line) && no_digit_after?(start, number, line)
      next unless symbol_right?(start, number, line) ||
        symbol_left?(start, number, line) ||
        symbol_up?(start, number, line, lines) ||
        symbol_down?(start, number, line, lines) ||
        symbol_top_right?(start, number, line, lines) ||
        symbol_top_left?(start, number, line, lines) ||
        symbol_bottom_right?(start, number, line, lines) ||
        symbol_bottom_left?(start, number, line, lines)

      numbers_adjacent_to_symbols << number.to_i
    end
  end
end


pp numbers_adjacent_to_symbols.sum
