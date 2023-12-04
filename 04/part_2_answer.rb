require 'pry'
require 'pry-nav'

input = File.read('04/input.txt')

deck = {}

def increment_winning_cards(card_number, overall_deck, count)
  start = card_number.to_i + 1
  finish = card_number.to_i + count
  (start..finish).each do |i|
    current_count = overall_deck[i.to_s].to_i
    overall_deck[i.to_s] = current_count + 1
  end
end

input.split("\n").each do |card|
  card_number = card.slice!(/.*:/).gsub(':', '').match(/\d+/)[0]

  card_count = deck[card_number].to_i + 1
  deck[card_number] = card_count

  number_sets = card.split('|')
  winning, have = number_sets.map { |set| set.split(' ').map(&:strip) }
  intersection_count = (winning & have).count

  card_count.times { increment_winning_cards(card_number, deck, intersection_count) }
end

pp deck.values.sum
