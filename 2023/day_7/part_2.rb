input = File.read('input.txt')
pairs = input.split("\n").map(&:split).to_h
$cards = %w(A K Q T 9 8 7 6 5 4 3 2 J).reverse.zip(1..13).to_h.freeze

def sum_of_products(pairs)
  sort_hands(pairs).map.with_index do |pair, index|
    (index + 1) * pair[1].to_i
  end.sum
end

def sort_hands(pairs)
  pairs.sort do |a, b|
    compare(a[0].chars, b[0].chars)
  end
end

def compare(a, b)
  comparison = type(a) <=> type(b)
  comparison == 0 ? compare_cards(a, b) : comparison
end

def compare_cards(a, b)
  a_values = a.map { $cards[_1] }
  b_values = b.map { $cards[_1] }
  a_values <=> b_values
end

def type(hand)
  hand = (hand.include?('J') ? j_value(hand) : hand).tally

  return 7 if hand.count == 1
  return 6 if hand.any? { _2 == 4 }
  return 5 if hand.count == 2
  return 4 if hand.any? { _2 == 3 }
  return 3 if hand.count == 3
  return 2 if hand.any? { _2 == 2 }
  1
end

# - To determine a cards value with J
# - Could be anything to increase the value
# - Convert J to card with the highest tally
# - If all J's, return hand.

def j_value(hand)
  return hand if hand.all?('J')

  highest_tally = hand.reject { _1 == 'J' }.sort_by { hand.count(_1) }.last
  hand.map { _1 == 'J' ? highest_tally : _1 }
end

p sum_of_products(pairs)
