file = File.open('input.txt').readlines.map(&:chomp)
cards = file.map { |row| row.split(': ') }

def format(cards)
  cards.map do |card|
    card[1].split(' | ').map { |row| row.split(' ') }
  end.map.with_index { |card, index| [index + 1, card] }.to_h
end

def total_winning_numbers(card)
  winning_numbers, numbers_you_have = card
  (winning_numbers & numbers_you_have).size
end

copies_won = format(cards).each_with_object({}) do |(key, value), hash|
  matches = total_winning_numbers(value)
  hash[key] = (key + 1..key + matches).to_a
end

result = (1..cards.size).to_a.product([1]).to_h
result.each do |card, card_count|
  cards_won = copies_won[card]
  cards_won.each { |card_won| result[card_won] += card_count }
end

p result.values.sum
