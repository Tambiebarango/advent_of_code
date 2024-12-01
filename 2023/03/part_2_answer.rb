input = File.read('03/input.txt')

lines = input.split("\n")
gears = []

def number_right(start, line)
  match = line[start+1..].match(/^[\d]+/)

  match[0].to_i if match
end

def number_left(start, line)
  match = line[0..start-1].match(/[\d]+$/)

  match[0].to_i if match
end

def number_up(start, line, lines)
  current_line_index = lines.index(line)
  return if current_line_index == 0

  line_above = lines[current_line_index - 1]

  return unless line_above[start].match?(/\d/)

  "#{line_above[..start - 1].match /\d+$/}#{line_above[start]}#{line_above[start + 1..].match /^\d+/}".to_i
end

def number_down(start, line, lines)
  current_line_index = lines.index(line)
  return if current_line_index == lines.length - 1

  line_below = lines[current_line_index + 1]

  return unless line_below[start].match?(/\d/)

  "#{line_below[..start - 1].match /\d+$/}#{line_below[start]}#{line_below[start + 1..].match /^\d+/}".to_i
end

def number_top_right(start, line, lines)
  current_line_index = lines.index(line)
  return if current_line_index == 0 || start == line.length - 1

  line_above = lines[current_line_index - 1]

  return if line_above[start].match?(/\d/)
  return unless line_above[start + 1].match?(/\d/)

  line_above[start + 1..].match(/^\d+/)[0].to_i
end

def number_top_left(start, line, lines)
  current_line_index = lines.index(line)
  return if current_line_index == 0 || start == 0

  line_above = lines[current_line_index - 1]

  return if line_above[start].match?(/\d/)
  return unless line_above[start - 1].match?(/\d/)

  line_above[..start-1].match(/\d+$/)[0].to_i
end

def number_bottom_right(start, line, lines)
  current_line_index = lines.index(line)
  return if current_line_index == lines.length - 1 || start == line.length - 1

  line_below = lines[current_line_index + 1]

  return if line_below[start].match?(/\d/)
  return unless line_below[start + 1].match?(/\d/)

  line_below[start + 1..].match(/^\d+/)[0].to_i
end

def number_bottom_left(start, line, lines)
  current_line_index = lines.index(line)
  return if current_line_index == lines.length - 1 || start == 0

  line_below = lines[current_line_index + 1]

  return if line_below[start].match?(/\d/)
  return unless line_below[start - 1].match?(/\d/)

  line_below[..start - 1].match(/\d+$/)[0].to_i
end

lines.each do |line|
  positions = line.to_enum(:scan, /\*/).map { Regexp.last_match.begin(0) }

  positions.each do |position|
    gears << [
      number_right(position, line),
      number_left(position, line),
      number_up(position, line, lines),
      number_down(position, line, lines),
      number_top_right(position, line, lines),
      number_top_left(position, line, lines),
      number_bottom_right(position, line, lines),
      number_bottom_left(position, line, lines)
    ].compact
  end
end

real_gears = gears.select { |g| g.size == 2 }
result = real_gears.map do |axles|
  axles.inject(&:*)
end.sum
pp result
