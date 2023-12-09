# - You get a list of hands.
# - Order them based on the strength of each hand.
# - A hands consists of 5 cards with labels:
#   - A, K, Q, J, T, 9, 8, 7, 6, 5, 4, 3, or 2
# - The relative strength follows the order.

# - Every hand is exactly 1 type, from stronges to weakest:
#   - Five of a kind, where all five cards have the same label: AAAAA
#   - Four of a kind, where four cards have the same label and one card has a different label: AA8AA
#   - Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
#   - Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
#   - Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
#   - One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
#   - High card, where all cards' labels are distinct: 23456
# - To break a tie compare each card of hands.

# - You have a list of hands & corresponding bid
# 32T3K 765
# T55J5 684
# KK677 28
# KTJJT 220
# QQQJA 483

# - Hands win equal to bid * rank.
# - 1 for weakest and n for strongest.
# - Find the rank of every hand
# - What are the total winnings?

=begin
  Breakdown
    - Each hand can be ranked.
    - The order is based on the following:
      - Type of hand or in case of ties.
      - Compare each card in 2 hands.
    - Input: String
    - Output: Number

  Data structure
    - [2, 4, 3, 1] - num1 > num2 ? num1, num2 = num2, num1 : next
    - [2, 4, 3, 1]
    - [2, 3, 4, 1]
    - [2, 3, 1, 4]
    - Can count the number of times

  Problem
    - Sort the hands
    - Get products of hand index & bid
    - Return the sum of products
=end

input = File.read('input.txt')
pairs = input.split("\n").map(&:split).to_h
hands, bids = pairs.keys, pairs.values
$cards = %w(A K Q J T 9 8 7 6 5 4 3 2).reverse.zip(1..13).to_h.freeze

def sort_hands(hands)
  hands.map(&:chars).sort do |a, b|
    a_type = find_type(a)
    b_type = find_type(b)
    compare(a, b)
  end
end

def type(hand)
  :five_of_a_kind if hand.all? { _1 }
  :four_of_a_kind if 
  end
end

def compare(a, b)

end
