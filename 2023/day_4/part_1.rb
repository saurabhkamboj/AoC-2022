# The card contains the following:
#   - Card number
#   - Winning numbers
#   - Numbers you have

file = File.open('input.txt').readlines.map(&:chomp)
cards = file.map { |row| row.split(': ') }

# - Compare winning numbers with numbers you have.
# - Add 1 then double the points for each match.
# - Return the sum of worth (Points) of cards.

def worth_in_total(cards)
  cards.map do |card|
    matches = total_winning_numbers(card)

    case matches
    when 0 then 0
    when 1 then 1
    when 2 then 2
    else
      calculate_points(matches)
    end
  end.sum
end

def total_winning_numbers(card)
  card_parts = card[1].split(' | ')
  winning_numbers = card_parts[0].split(' ')
  numbers_you_have = card_parts[1].split(' ')

  winning_numbers.each_with_object([]) do |winning_number, result|
    numbers_you_have.each do |number_you_have|
      result << winning_number if winning_number == number_you_have
    end
  end.length
end

def calculate_points(matches)
  (1..matches - 2).inject(2) do |product, _|
    product * 2
  end
end

# Alternate
def worth_in_total(cards)
  cards.map do |card|
    (2**(total_winning_numbers(card) - 1)).to_i
  end.sum
end

def total_winning_numbers(card)
  card_parts = card[1].split(' | ')
  winning_numbers = card_parts[0].split(' ')
  numbers_you_have = card_parts[1].split(' ')

  (winning_numbers & numbers_you_have).size
end

p worth_in_total(cards)
