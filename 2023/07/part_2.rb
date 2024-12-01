require 'pry'
require 'pry-nav'

input = File.read('07/input.txt').split("\n")

CARD_RANK = { 'A': 14, 'K': 13, 'Q': 12, 'T': 10, '9': 9, '8': 8, '7': 7, '6': 6, '5': 5, '4': 4, '3': 3, '2': 2, 'J': 1 }.freeze
LOWEST_TO_HIGHEST_RANK = %w[high_card one_pair two_pair three_of_a_kind full_house four_of_a_kind five_of_a_kind].freeze

def count_hand(cards)
  cards.each_with_object({}) do |card, hash|
    current_count = hash[card] || 0
    hash[card] = current_count + 1
  end
end

def evaluate_hand(counts)
  values = counts.values

  return 'high_card' if values.all? { |c| c == 1 }
  return 'five_of_a_kind' if values.any? { |c| c == 5 }
  return 'four_of_a_kind' if values.any? { |c| c == 4 }
  return 'full_house' if values.any? { |c| c == 3 } && values.any? { |c| c == 2 }
  return 'three_of_a_kind' if values.any? { |c| c == 3 } && values.any? { |c| c == 1 }
  return 'two_pair' if values.count { |c| c == 2 } == 2
  return 'one_pair' if values.count { |c| c == 2 } == 1 && values.uniq.sort == [1, 2].sort

  nil
end

def joker_evaluate_hand(type, counts)
  return type unless counts.key?("J")
  return type if counts.keys.uniq == ["J"]

  j_count = counts.delete('J')
  current_max_key = counts.max_by { |k, v| v }[0]
  counts[current_max_key] += j_count

  evaluate_hand(counts)
end

def evaluate_table(table)
  next_rank = 1

  LOWEST_TO_HIGHEST_RANK.each do |rank|
    hands = table.select { |hand| hand[:joker_type] == rank }

    next if hands.empty?

    hands.sort_by { |hand| (1..5).map { |i| hand["card_#{i}"] } }.each do |hand|
      hand[:rank] = next_rank
      next_rank += 1
    end
  end
end

table = input.map do |line|
  hand, bid = line.split(' ')

  cards = hand.chars.each_with_index.each_with_object({}) do |ewi, hash|
    card, index = ewi
    hash["card_#{index + 1}"] = CARD_RANK[card.to_sym]
  end

  counts = count_hand(hand.chars)
  type = evaluate_hand(counts)

  {
    **cards,
    bid: bid.to_i,
    all_cards: hand.chars,
    counts: counts,
    joker_type: joker_evaluate_hand(type, counts)
  }
end

evaluate_table(table)

result = table.inject(0) do |sum, hand_info|
  sum + (hand_info[:bid] * hand_info[:rank])
end

pp result
