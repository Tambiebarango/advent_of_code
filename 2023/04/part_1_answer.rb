require 'pry'
require 'pry-nav'

input = File.read('04/input.txt')

# Part 1
def score(card_numbers)
  return 0 if card_numbers.empty?
  return 1 if card_numbers.one?

  card_numbers.each_with_index.inject(0) do |total_score, number_and_index|
    _number, index = number_and_index

    index.zero? ? total_score += 1 : total_score *= 2
    total_score
  end
end

cards = input.split("\n")
card_info = cards.inject({}) do |memo, card|
  card_name = card.slice!(/.*:/).gsub(':', '')
  number_sets = card.split('|')
  winning, have = number_sets.map { |set| set.split(' ').map(&:strip) }
  memo[card_name] = {
    winning: winning,
    have: have,
    intersection: winning & have,
    score: score(winning & have)
  }
  memo
end

pp card_info.values.map { |v| v[:score] }.sum
