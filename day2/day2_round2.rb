require 'pry'
require 'yaml'

WINS = [['A', 'C'], ['C', 'B'], ['B', 'A']]

def format_array(str)
  base_array = str.split("\n")

  base_array.each do |i|
    i.delete! " "
  end
end

def find_player(opponent, outcome)
  player = ''

  if outcome == 'Z' # player wins
    WINS.each do |win|
      player = win[0] if win[1] == opponent
    end
  elsif outcome == 'X' # player loses
    WINS.select do |win|
      player = win[1] if win[0] == opponent
    end
  else
    player = opponent
  end

  player
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
