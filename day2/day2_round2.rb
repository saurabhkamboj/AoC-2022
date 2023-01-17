require 'pry'
require 'yaml'

WINS = [['A', 'C'], ['C', 'B'], ['B', 'A']]

def format_array(str)
  base_array = str.split("\n")

  base_array.map do |i|
    i.delete! " "
  end
end

def find_player(opponent, outcome)
  if outcome == 'Z' # player wins
    WINS.select { |win| win[1] == opponent }.flatten[0]
  elsif outcome == 'X' # player loses
    WINS.select { |win| win[0] == opponent }.flatten[1]
  else
    opponent
  end
end

def round_score(opponent, outcome)
  player = find_player(opponent, outcome)
  score = 0

  case outcome
  when 'X'
    score += 0
  when 'Y'
    score += 3
  when 'Z'
    score += 6
  end

  case player
  when 'A'
    score += 1
  when 'B'
    score += 2
  when 'C'
    score += 3
  end

  score
end

def total_score(str)
  array = format_array(str)
  total_score = []

  array.each do |i|
    total_score << round_score(i[0], i[1])
  end

  total_score.sum
end

string = YAML.load_file("day2_input.yml")

p total_score(string)
