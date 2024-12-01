input = File.read('02/input.txt')

# Part 1

MAX_RED = 12
MAX_GREEN = 13
MAX_BLUE = 14

valid_game_ids = []

input.split("\n").each do |line|
  game_info = line.slice!(/Game \d+\:\s*/)
  game_id = game_info.match(/Game (?<game>\d+)/)[:game].to_i

  r, g, b = %w[red green blue].map { |c| line.scan(/(\d+) #{c}/).flatten.map(&:to_i) }
  valid_game_ids << game_id if r.max <= MAX_RED && g.max <= MAX_GREEN && b.max <= MAX_BLUE
end

puts valid_game_ids.sum
# 2600


# Part 2

result = input.split("\n").map do |line|
  %w[red green blue].map { |c| line.scan(/(\d+) #{c}/).flatten.map(&:to_i).max }.inject(:*)
end

pp result.sum
# 86036
